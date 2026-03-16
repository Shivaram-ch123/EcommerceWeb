package service;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import entity.OrderItem;
import entity.Orders;
import entity.Users;
import repository.*;

@Service
public class OrderService {

	@Autowired
	OrderRepository ordersRepository;
	@Autowired
	private OrderItemRepository orderItemRepository;

	public void saveOrder(Orders order) {
		ordersRepository.save(order);
	}

	public List<Orders> showOrderItems(Users user) {
		// i need to get all the rows in the orders table
		List<Orders> list = ordersRepository.getRowsUserId(user);

		return list;
	}

	public void removeOrderItem(int orderItemId, int userId) {
		Optional<OrderItem> optionalItem = orderItemRepository.findById(orderItemId);
		if (optionalItem.isPresent()) {
			OrderItem item = optionalItem.get();

			// Check ownership
			if (item.getOrder().getUser().getId() == userId) {
				Orders order = item.getOrder();

				// Remove from the parent collection
				order.getProducts().remove(item);

				// Save the parent order to trigger orphanRemoval
				ordersRepository.save(order);

				System.out.println("Order item removed successfully!");
			}
		}
	}
}