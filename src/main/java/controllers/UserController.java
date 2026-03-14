package controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entity.Users;
import service.UserService;

@Controller
@RequestMapping("/")
public class UserController {
	// some services objects that i need here
	@Autowired
	UserService userService;

	@PostMapping("/registerUser")
	public String registerUser(Users user) {
		System.out.println(user.getId() + " " + user.getEmail() + " " + user.getPassword());
		// i need to use thoes services here
		System.out.println("You are in registerUser Methods");
		if (userService.registerUser(user)) {
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

}
