package controllers;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entity.CartItems;
import entity.Information;
import entity.OrderItem;
import entity.Orders;
import entity.Products;
import entity.Users;
import entity.WishlistItem;
import repository.wishlistRepository;
import service.OrderService;
import service.ProductService;
import service.UserService;
import service.wishlistService;

@Controller
@RequestMapping("/")
public class UserController {
	// some services objects that i need here
	@Autowired
	UserService userService;
	@Autowired
	ProductService productService;
	@Autowired
	wishlistService wishlistService;
	@Autowired
	OrderService orderService;

	@PostMapping("/registerUser")
	public String registerUser(@Valid @ModelAttribute("user") Users user, BindingResult bindingResult, Model model) {
		System.out.println("You are in registerUser Method");

		// Check for validation errors
		if (bindingResult.hasErrors()) {
			return "Register"; // return back to JSP with errors
		}

		System.out.println(user.getId() + " " + user.getEmail() + " " + user.getPassword());

		// Use your existing service to register user
		if (userService.registerUser(user)) {
			// Set default user information
			Information information = new Information("none", "/images/pImage.jpg", user);
			userService.saveInformation(information);
			return "LoginPage"; // registration successful
		}

		// If something went wrong during registration
		model.addAttribute("errorMessage", "Something went wrong. Please try again.");
		return "Register";
	}

	@RequestMapping("/showlogin")
	public String showLoginPage() {
		return "LoginPage";
	}

	@GetMapping("")
	public String showRegisterForm(Model model) {
		model.addAttribute("user", new Users());
		return "redirect:/showCategory?category=";
	}

	@GetMapping("showhomepag")
	public String showhome() {
		return "redirect:/showCategory?category=";
	}

	@GetMapping("/register")
	public String showReg(Model model) {
		model.addAttribute("user", new Users());
		return "Register"; // JSP name
	}

	@PostMapping("/addToCart")
	public String addToCart(@RequestParam("productId") Integer productId, HttpSession session,
			RedirectAttributes redirectAttrs) { // Add RedirectAttributes

		Users user = (Users) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/register";
		}

		System.out.println(">>>> addToCart HIT <<<<");
		System.out.println("session currentUser = " + session.getAttribute("currentUser"));

		String message = userService.addToCart(user, productId);
		redirectAttrs.addFlashAttribute("cartMessage", message);

		return "redirect:/showCategory?category=";
	}

	@PostMapping("/checkUser")
	public String checkUser(@RequestParam("email") String email, @RequestParam("password") String password,
			HttpSession session) {

		Users user = userService.checkUserExistsReturn(email, password);
		if (user != null) {
			session.setAttribute("currentUser", user);
			return "redirect:/showCategory?category=";
		}
		return "LoginPage";
	}

	@RequestMapping("/myProfile")
	public String showProfile(HttpSession session, Model model) {
		Users user = (Users) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/register";
		}

		if (user != null) {
			Information info = userService.getInformationByUser(user);

			model.addAttribute("user", user);
			model.addAttribute("info", info);
		}

		return "profile";
	}

	@GetMapping("/updateProfile")
	public String showUpdateProfile(HttpSession session, Model model) {

		Users currentUser = (Users) session.getAttribute("currentUser");

		if (currentUser != null) {
			model.addAttribute("user", currentUser);
		} else {
			model.addAttribute("errorMessage", "Please login first to update profile!");
			return "profile";
		}

		return "updateProfile";
	}

	@PostMapping("/updateProfileDetails")
	public String updateProfileDetails(Users updatedUser, HttpSession session, RedirectAttributes redirectAttrs) {

		Users currentUser = (Users) session.getAttribute("currentUser");

		if (currentUser == null) {
			redirectAttrs.addFlashAttribute("errorMessage", "Please login first to update profile!");
			return "redirect:/myProfile";
		}

		if (currentUser.getId() != updatedUser.getId()) {
			redirectAttrs.addFlashAttribute("errorMessage", "Invalid user update attempt!");
			return "redirect:/myProfile";
		}

		try {

			// i want the users list
			List<Users> list = userService.getAllUsers();
			for (int i = 0; i < list.size(); i++) {
				if (list.get(i).getId() == updatedUser.getId())
					continue;

				if (list.get(i).getEmail().equals(updatedUser.getEmail())
						|| list.get(i).getUserName().equals(updatedUser.getUserName())) {
					return "redirect:/updateProfile";
				}
			}

			userService.updateUserProfile(updatedUser);

			session.setAttribute("currentUser", updatedUser);

			redirectAttrs.addFlashAttribute("successMessage", "Profile updated successfully!");
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttrs.addFlashAttribute("errorMessage", "Something went wrong while updating profile.");
		}

		return "redirect:/updateProfile";
	}

	@PostMapping("/addToWishlist")
	public String addToWishlist(Long productId, HttpSession session, RedirectAttributes redirectAttributes) {

		Users user = (Users) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/register";
		}

		Products product = productService.getProductById(productId);
		if (product == null) {
			redirectAttributes.addFlashAttribute("cartMessage", "Product not found!");
			return "redirect:/showCategory?category=";
		}

		boolean added = wishlistService.addProductToWishlist(user, product);
		if (added) {
			redirectAttributes.addFlashAttribute("cartMessage", "Product added to your wishlist!");
		} else {
			redirectAttributes.addFlashAttribute("cartMessage", "Product is already in your wishlist!");
		}

		return "redirect:/showCategory?category=";
	}

	@GetMapping("/showWishlist")
	public String showWishlist(HttpSession session, Model model) {
		Users user = (Users) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/login";
		}
		List<Products> wishlist = wishlistService.getWishlistByUser(user);
		model.addAttribute("wishlistProducts", wishlist);
		return "wishlist";
	}

	@PostMapping("/removeFromWishlist")
	public String removeFromWishList(@RequestParam("productId") Long productId, HttpSession session) {
		Users user = (Users) session.getAttribute("currentUser");
		boolean ans = wishlistService.removeProductFromWishlist(user, productId);
		if (ans) {
			return "redirect:/showWishlist";
		}
		return "error";
	}

	@GetMapping("/home")
	public String home() {
		return "HomePage";
	}

	@PostMapping("/buyNow")
	public String buyNow(@RequestParam("productId") long productId, Model model) {
		model.addAttribute("productId", productId);
		return "getDetails";
	}

	@PostMapping("/placeOneOrder")
	public String placeOneOrder(@RequestParam String address, @RequestParam String paymentMode,
			@RequestParam long productId, // capture the productId
			HttpSession session, Model model) {

		Users user = (Users) session.getAttribute("currentUser");

		// Create new order
		Orders order = new Orders();
		order.setUser(user);
		order.setAddress(address);
		order.setPaymentMode(paymentMode);

		// ✅ Random delivery date between 4 and 10 days from today
		int randomDays = 4 + (int) (Math.random() * 7); // 4 + 0..6 = 4..10
		order.setDateOfDelivery(LocalDate.now().plusDays(randomDays));

		// Prepare order item
		List<OrderItem> orderItems = new ArrayList<>();
		Products product = productService.getProductById(productId);

		if (product != null) {
			OrderItem orderItem = new OrderItem();
			orderItem.setOrder(order);
			orderItem.setProduct(product);
			orderItem.setQuantity(1); // default quantity for buyNow
			orderItems.add(orderItem);
		}

		order.setProducts(orderItems);

		// Calculate total amount
		double totalAmount = orderItems.stream().mapToDouble(item -> item.getQuantity() * item.getProduct().getCost())
				.sum();
		double finalPrice = (totalAmount < 300 ? totalAmount + 120 : totalAmount);
		order.setTotalAmount(finalPrice);

		// Save order
		orderService.saveOrder(order);

		// Pass order to JSP for summary display
		model.addAttribute("order", order);

		return "orderSuccess"; // shows order success page
	}

}
