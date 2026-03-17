package controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import entity.*;

import java.time.LocalDate;
import java.util.*;

import repository.CartItemsRepository;
import repository.ProductRepository;
import service.CartService;
import service.ImageService;
import service.OrderService;

@Controller
public class OrdersController {
	@Autowired
	OrderService orderService;
	@Autowired
	CartItemsRepository cartItemsRepository;
	@Autowired
	ProductRepository productRepository;

	@Autowired
	ImageService imageService;

	@PostMapping("/checkout")
	public String checkoutPage() {
		return "checkout";
	}

	@PostMapping("/placeOrder")
	public String placeOrder(@RequestParam String address, @RequestParam String paymentMode,
			@RequestParam int deliveryDays, @RequestParam double totalAmount, HttpSession session, Model model) { 
																													
																													

		Users user = (Users) session.getAttribute("currentUser");

		List<CartItems> cartList = cartItemsRepository.getCartItemsByUserId(user.getId());

		Orders order = new Orders();
		order.setUser(user);
		order.setAddress(address);
		order.setPaymentMode(paymentMode);

		
		LocalDate deliveryDate = LocalDate.now().plusDays(deliveryDays);
		order.setDateOfDelivery(deliveryDate);

	
		order.setTotalAmount(totalAmount);

		List<OrderItem> orderItems = new ArrayList<>();

		for (CartItems item : cartList) {

			Products product = productRepository.findById((long) item.getProduct().getId()).orElse(null);

			if (product != null) {

			
				int newStock = product.getStock() - item.getQuantity();
				if (newStock < 0)
					newStock = 0; 
				product.setStock(newStock);
				productRepository.save(product); 

				
				OrderItem orderItem = new OrderItem();
				orderItem.setOrder(order);
				orderItem.setProduct(product);
				orderItem.setQuantity(item.getQuantity());
				orderItem.setStatus("ACTIVE"); // mark active

				orderItems.add(orderItem);
			}
		}

		order.setProducts(orderItems);

		orderService.saveOrder(order);

		cartItemsRepository.deleteAll(cartList);

	
		model.addAttribute("order", order);

		return "orderSuccess";
	}

	@GetMapping("/myOrders")
	public String showMyOrder(HttpSession session, org.springframework.ui.Model model) {
		Users user = (Users) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/register";
		}

		List<Orders> ordersList = orderService.showOrderItems(user);

		// Map to hold productId -> list of images
		Map<Long, Images> productImagesMap = new HashMap<>();

		for (Orders order : ordersList) {
			for (OrderItem item : order.getProducts()) { // assuming order.getProducts() returns List<OrderItems>
				Long productId = item.getProduct().getId();
				// Fetch images for this product
				Images images = imageService.getImageByProductId(productId);
				productImagesMap.put(productId, images);
			}
		}

		model.addAttribute("ordersList", ordersList);
		model.addAttribute("productImagesMap", productImagesMap); // pass map to JSP

		return "myOrders";
	}

	@PostMapping("/cancelProduct")
	public String cancelProduct(@RequestParam("orderItemId") int orderItemId, HttpSession session, Model model) {
		Users user = (Users) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/startpoint"; // user not logged in
		}

		orderService.removeOrderItem(orderItemId, user.getId());

		List<Orders> ordersList = orderService.showOrderItems(user);

		// Map to hold productId -> list of images
		Map<Long, Images> productImagesMap = new HashMap<>();

		for (Orders order : ordersList) {
			for (OrderItem item : order.getProducts()) { // assuming order.getProducts() returns List<OrderItems>
				Long productId = item.getProduct().getId();
				// Fetch images for this product
				Images images = imageService.getImageByProductId(productId);
				productImagesMap.put(productId, images);
			}
		}

		model.addAttribute("ordersList", ordersList);
		model.addAttribute("productImagesMap", productImagesMap); // pass map to JSP

		return "redirect:/myOrders"; // refresh the orders page
	}

}
