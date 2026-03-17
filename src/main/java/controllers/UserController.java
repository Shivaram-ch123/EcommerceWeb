package controllers;
import java.util.*;
import repository.*;
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
import entity.Images;
import entity.Information;
import entity.OrderItem;
import entity.Orders;
import entity.Products;
import entity.Users;
import entity.WishlistItem;
import repository.wishlistRepository;
import service.CartService;
import service.ImageService;
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
	@Autowired
	InformationRepository informationRepository;
	@Autowired
	CartService cartService;
	@Autowired
	ImageService imageService;
	@Autowired
	CartItemsRepository cartItemsRepository;

	@PostMapping("/registerUser")
	public String registerUser(@Valid @ModelAttribute("user") Users user, BindingResult bindingResult, Model model) {
		System.out.println("You are in registerUser Method");

		// Check for validation errors
		if (bindingResult.hasErrors()) {
			return "Register"; // return back to JSP with errors
		}

		System.out.println(user.getId() + " " + user.getEmail() + " " + user.getPassword());

		
		if (userService.registerUser(user)) {
			
			Information information = new Information("none", "/images/pImage.jpg", user);
			userService.saveInformation(information);
			return "redirect:/showCategory?category="; 
		}
		else {
			
		}

		
		model.addAttribute("errorMessage", "Email Exists. Please try again.");
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

	@GetMapping("/showhomepag")
	public String showhome() {
		return "redirect:/showCategory?category=";
	}

	@GetMapping("/register")
	public String showReg(Model model) {
		model.addAttribute("user", new Users());
		return "Register"; // JSP name
	}

	@PostMapping("/addToCart")
	public String addToCart(@RequestParam("productId") Integer productId,
	                       HttpSession session,
	                       RedirectAttributes redirectAttrs,
	                       Model model) {

	    Users user = (Users) session.getAttribute("currentUser");
	    if (user == null) {
	        return "redirect:/register";
	    }

	    int userId = user.getId();

	    // Get current quantity of this product in user's cart
	    int userQuantity =cartService.updateCartItemQuantity(userId, productId, 0); 

	    Products product = productService.getProductById((long) productId);

	    // 🔴 STOCK CHECK
	    if (userQuantity >= product.getStock()) {
	        redirectAttrs.addFlashAttribute("cartMessage", "No stock available for this product!");
	        return "redirect:/showCategory?category=";
	    }

	    // ✅ ADD TO CART
	    String message = userService.addToCart(user, productId);
	    redirectAttrs.addFlashAttribute("cartMessage", message);

	    return "redirect:/showCategory?category=";
	}
	@PostMapping("/addToCart1")
	public String addToCart1(@RequestParam("productId") Integer productId,
	                       HttpSession session,
	                       RedirectAttributes redirectAttrs,
	                       Model model) {

	    Users user = (Users) session.getAttribute("currentUser");
	    if (user == null) {
	        return "redirect:/register";
	    }

	    int userId = user.getId();

	    // Get current quantity of this product in user's cart
	    int userQuantity =cartService.updateCartItemQuantity(userId, productId, 0); 

	    Products product = productService.getProductById((long) productId);

	    // 🔴 STOCK CHECK
	    if (userQuantity >= product.getStock()) {
	        redirectAttrs.addFlashAttribute("cartMessage", "No stock available for this product!");
	        return "redirect:/isAvailable";
	    }

	    // ✅ ADD TO CART
	    String message = userService.addToCart(user, productId);
	    redirectAttrs.addFlashAttribute("cartMessage", message);
	    
	    return "redirect:/viewProductdublicate?productId="+productId;
	}
	
	@GetMapping("/isAvailable")
	public String temp() {
		return "ordersNotAvailable";
	}

	@PostMapping("/checkUser")
	public String checkUser(@RequestParam("email") String email, @RequestParam("password") String password,
			HttpSession session ,Model model) {

		Users user = userService.checkUserExistsReturn(email, password);
		if (user != null) {
			session.setAttribute("currentUser", user);
			return "redirect:/";
		}
		 
		return "redirect:/showlogin";
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
	public String updateProfileDetails(Users updatedUser, HttpSession session, RedirectAttributes redirectAttrs,@RequestParam("address") String add) {
		
		
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
			
			// here i need to save in to the infotable
			Information info=  informationRepository.findByUser(updatedUser);
			info.setAddress(add);
			informationRepository.save(info);

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
			return "redirect:/showlogin";
		}
		List<Products> wishlist = wishlistService.getWishlistByUser(user);

		// map product IDs to their first image (if exists)
		Map<Long, Images> productImages = new HashMap<>();
		for (Products p : wishlist) {
		    Images img = imageService.getImageByProductId(p.getId()); 
		    if (img != null) {
		        productImages.put(p.getId(), img);
		    }
		}

		model.addAttribute("wishlistProducts", wishlist);
		model.addAttribute("productImages", productImages);
		
		
		

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
	
	@GetMapping("/viewProductdublicate")
	public String home1(@RequestParam("productId") Long productId, Model model) {
		
		Products product = productService.getProductById(productId);
		Images image = imageService.getImageByProductId(productId);

		model.addAttribute("product", product);
		model.addAttribute("image",image);

		return "wishlistviewProduct";
	}

	@PostMapping("/buyNow")
	public String buyNow(@RequestParam("productId") long productId, Model model,HttpSession session) {
		model.addAttribute("productId", productId);
		
		
		//Users user = (Users) session.getAttribute("currentUser");

		
		Users user = (Users) session.getAttribute("currentUser");

		Products product = productService.getProductById(productId);
			if(1>product.getStock()) {
				return "ordersNotAvailable";
			}
		
		
		
		
		
		
		
		
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
