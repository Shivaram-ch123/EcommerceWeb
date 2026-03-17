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

			// ownership check
			if (item.getOrder().getUser().getId() == userId) {

				Orders order = item.getOrder();

				// calculate removed item price
				double cost = item.getProduct().getCost();
				int qty = item.getQuantity();
				double removedAmount = cost * qty;

				double newTotal = order.getTotalAmount() - removedAmount;

				if (newTotal < 0) {
					newTotal = 0;
				}

				// mark item as cancelled
				item.setStatus("CANCELLED");

				// check if any ACTIVE items remain
				boolean hasActiveItem = false;
				double sum=0;
				for (OrderItem oi : order.getProducts()) {
					if (oi.getStatus().equals("ACTIVE") && oi.getId() != item.getId()) {
						hasActiveItem = true;
					}
					
					if(oi.getStatus().equals("ACTIVE"))sum+=oi.getProduct().getCost();
					
				}

				newTotal=sum;
				if(newTotal < 300)newTotal+=120;
				if (!hasActiveItem) {
					newTotal = 0;
				}
				
				
				
				order.setTotalAmount(newTotal);

				// save
				ordersRepository.save(order);
				orderItemRepository.save(item);

				System.out.println("Order item cancelled and total updated!");
			}
		}
	}
}