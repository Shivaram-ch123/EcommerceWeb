package controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import entity.*;

import java.time.LocalDate;
import java.util.*;
import entity.CartItems;
import entity.Users;
import repository.CartItemsRepository;
import repository.ProductRepository;
import service.CartService;
import service.OrderService;

@Controller
public class OrdersController {
	@Autowired
	OrderService orderService;
	@Autowired
	CartItemsRepository cartItemsRepository;
	@Autowired
	ProductRepository productRepository;

	@GetMapping("/checkout")
	public String checkoutPage() {
		return "checkout";
	}

	@PostMapping("/placeOrder")
	public String placeOrder(@RequestParam String address, @RequestParam String dateOfDelivery,
			@RequestParam String paymentMode, HttpSession session) {

		Users user = (Users) session.getAttribute("currentUser");

		// get cart items
		List<CartItems> cartList = cartItemsRepository.getCartItemsByUserId(user.getId());

		// convert cart items -> products list
		List<Products> products = new ArrayList<>();

		for (CartItems item : cartList) {
			Products product = productRepository.findById((long) item.getProductId()).orElse(null);
			if (product != null) {
				products.add(product);
			}
		}

		// create order
		Orders order = new Orders();
		order.setUser(user);
		order.setProducts(products);
		order.setAddress(address);
		order.setPaymentMode(paymentMode);
		order.setDateOfDelivery(LocalDate.parse(dateOfDelivery));

		// save order
		orderService.saveOrder(order);

		// clear cart
		cartItemsRepository.deleteAll(cartList);

		return "orderSuccess";
	}

}
