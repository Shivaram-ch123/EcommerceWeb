package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import entity.*;
import repository.CartItemsRepository;

@Service
public class CartService {
	@Autowired
	private CartItemsRepository cartItemsRepository;
	@Autowired
	ProductService productService;

	public List<CartItems> GetProducts(int userId) {
		return cartItemsRepository.getCartItemsByUserId(userId);
	}

	public Products getProductById(Long productId) {
		return productService.getProductById(productId);
	}

	public void updateCartItemQuantity(int userId, int productId, int change) {
		CartItems item = cartItemsRepository.findByUserIdAndProductId(userId, productId);
		if (item != null) {
			item.setQuantity(item.getQuantity() + change);
			cartItemsRepository.save(item); // persist to DB
		}
		
	}
	public CartItems deleteCartItemQuantity(int userId, int productId) {
		CartItems item = cartItemsRepository.findByUserIdAndProductId(userId, productId);
		if (item != null) {
			if(item.getQuantity()>1) {
				item.setQuantity(item.getQuantity() - 1);
				cartItemsRepository.save(item); // persist to DB
			}
			else {
				cartItemsRepository.delete(item);
			}
				
		}
		return item;
	}
}
