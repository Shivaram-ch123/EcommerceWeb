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

		List<CartItems> cartList = cartItemsRepository.getCartItemsByUserId(user.getId());

		Orders order = new Orders();
		order.setUser(user);
		order.setAddress(address);
		order.setPaymentMode(paymentMode);
		order.setDateOfDelivery(LocalDate.parse(dateOfDelivery));

		List<OrderItem> orderItems = new ArrayList<>();

		for (CartItems item : cartList) {
			Products product = productRepository.findById((long) item.getProduct().getId()).orElse(null);

			if (product != null) {
				OrderItem orderItem = new OrderItem();
				orderItem.setOrder(order);
				orderItem.setProduct(product);
				orderItem.setQuantity(item.getQuantity()); // important

				orderItems.add(orderItem);
			}
		}

		order.setProducts(orderItems);

		orderService.saveOrder(order);

		cartItemsRepository.deleteAll(cartList);

		return "orderSuccess";
	}

	@GetMapping("/myOrders")
	public String showMyOrder(HttpSession session, org.springframework.ui.Model model) {
		Users user = (Users) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/register";
		}

		

		List<Orders> list = orderService.showOrderItems(user);
		HashMap<Orders, Integer> hmap = new HashMap<>();
		for (int i = 0; i < list.size(); i++) {
			List<OrderItem> productsList = list.get(i).getProducts();
			int sum = 0;
			for (int j = 0; j < productsList.size(); j++) {
				sum += (productsList.get(j).getQuantity() * productsList.get(j).getProduct().getCost());
			}
			hmap.put(list.get(i), sum);
		}

		model.addAttribute("ordersList", hmap);

		return "myOrders";
	}

	@PostMapping("/cancelProduct")
	public String cancelProduct(@RequestParam("orderItemId") int orderItemId, HttpSession session) {
		Users user = (Users) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/startpoint"; // user not logged in
		}

		orderService.removeOrderItem(orderItemId, user.getId());

		return "redirect:/myOrders"; // refresh the orders page
	}

}
