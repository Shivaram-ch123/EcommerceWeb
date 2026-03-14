package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import entity.Orders;
import repository.*;

@Service
public class OrderService {

	@Autowired
	OrderRepository ordersRepository;

	public void saveOrder(Orders order) {
		ordersRepository.save(order);
	}
}