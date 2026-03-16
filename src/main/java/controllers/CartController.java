package controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import java.util.*;

import entity.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entity.CartItems;
import entity.Users;
import service.CartService;
import service.UserService;

@Controller
public class CartController {
	// some services objects that i need here
	@Autowired
	CartService cartService;

	@GetMapping("/myCart")
	public String showCart(HttpSession session, Model model) {

		Users user = (Users) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/register";
		}

		List<CartItems> list = cartService.GetProducts(((Users) session.getAttribute("currentUser")).getId());

		Map<Integer, Products> productMap = new HashMap<>();
		for (CartItems item : list) {
			Products product = cartService.getProductById((long) item.getProduct().getId()); // you need this method
			productMap.put(item.getId(), product);
		}

		model.addAttribute("cartItems", list);
		model.addAttribute("productMap", productMap); // send product info separately

		return "myCartPage";
	}

	@PostMapping("/increase")
	public String incrementQuantity(@RequestParam("productId") int productId, HttpSession session) {

		// Get current user ID
		Users user = (Users) session.getAttribute("currentUser");
		int userId = user.getId();

		// Call service to update quantity in DB
		cartService.updateCartItemQuantity(userId, productId, 1); // 1 means increment by 1

		return "redirect:/myCart";
	}

	@PostMapping("/decrease")
	public String DecrementQuantity(@RequestParam("productId") int productId, HttpSession session) {

		// Get current user ID
		Users user = (Users) session.getAttribute("currentUser");
		int userId = user.getId();

		// Call service to update quantity in DB
		cartService.deleteCartItemQuantity(userId, productId); // 1 means increment by 1
		List<CartItems> afterUpdate = cartService.GetProducts(userId);

		return "redirect:/myCart";
	}

}
