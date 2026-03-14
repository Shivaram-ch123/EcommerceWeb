package RepositoryCustom;

import java.util.List;

import entity.CartItems;

public interface CartItemsRepositoryCustom {
	public void addProductToCart(int userId, int productId, int quantity);

	public List<CartItems> getCartItemsByUserId(int userId);

	CartItems findByUserIdAndProductId(int userId, int productId);
}
