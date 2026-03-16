package controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entity.Information;
import entity.Products;
import entity.Users;
import entity.WishlistItem;
import repository.wishlistRepository;
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

	@PostMapping("/registerUser")
	public String registerUser(Users user) {
		System.out.println(user.getId() + " " + user.getEmail() + " " + user.getPassword());
		// i need to use thoes services here
		System.out.println("You are in registerUser Methods");
		if (userService.registerUser(user)) {
			// i need to set the user Information
			Information information = new Information("none", "/images/pImage.jpg", user);
			userService.saveInformation(information);
			return "LoginPage";
		}
		return "SomeThingWengWrong";

	}

	@GetMapping("/startpoint")
	public String showRegisterForm() {
		return "Register"; // resolves to /WEB-INF/views/Register.jsp
	}

	@PostMapping("/addToCart")
	public String addToCart(@RequestParam("productId") Integer productId, HttpSession session,
			RedirectAttributes redirectAttrs) { // Add RedirectAttributes

		System.out.println(">>>> addToCart HIT <<<<");
		System.out.println("session currentUser = " + session.getAttribute("currentUser"));

		Users user = (Users) session.getAttribute("currentUser");
		if (user == null) {
			System.out.println("No user in session!");
			redirectAttrs.addFlashAttribute("cartMessage", "Please log in first!");
			return "redirect:/startpoint";
		}

		String message = userService.addToCart(user, productId);
		redirectAttrs.addFlashAttribute("cartMessage", message);

		// You might want to redirect to the category of the product or a default page
		return "redirect:/showCategory?category=all";
	}

	@PostMapping("/checkUser")
	public String checkUser(@RequestParam("email") String email, @RequestParam("password") String password,
			HttpSession session) { // add HttpSession here

		Users user = userService.checkUserExistsReturn(email, password); // fetch the user
		if (user != null) {
			// store the logged-in user in session
			session.setAttribute("currentUser", user);
			return "redirect:/showCategory?category=";
		}
		return "LoginPage";
	}

	@RequestMapping("/myProfile")
	public String showProfile(HttpSession session, Model model) {
		// Get logged-in user
		Users user = (Users) session.getAttribute("currentUser");

		if (user != null) {
			Information info = userService.getInformationByUser(user);

			model.addAttribute("user", user);
			model.addAttribute("info", info);
		} else {
			model.addAttribute("errorMessage", "Please login first!");
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
			redirectAttributes.addFlashAttribute("cartMessage", "Please log in first!");
			return "redirect:/login";
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

}
