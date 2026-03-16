package service;

import

repository.*;
import entity.*;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class wishlistService {

	@Autowired
	private wishlistRepository wishlistRepository;

	public boolean addProductToWishlist(Users user, Products product) {
		// Check if the product already exists
		if (wishlistRepository.existsByUserAndProduct(user, product)) {
			return false;
		}

		// Save new wishlist item

		WishlistItem item = new WishlistItem();
		item.setUser(user);
		item.setProduct(product);
		wishlistRepository.save(item);

		return true;
	}

	public List<Products> getWishlistByUser(Users user) {
		List<WishlistItem> wishlistItems = wishlistRepository.findByUser(user);
		List<Products> products = new ArrayList<>();

		for (WishlistItem item : wishlistItems) {
			products.add(item.getProduct());
		}

		return products;
	}

	public boolean removeProductFromWishlist(Users user, Long productId) {
		List<WishlistItem> wishlistItems = wishlistRepository.findByUser(user);

		for (WishlistItem item : wishlistItems) {
			if (item.getProduct().getId().equals(productId)) {
				wishlistRepository.delete(item);
				return true; // removed successfully
			}
		}

		return false; // product not found in wishlist
	}

}