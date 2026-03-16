package RepositoryCustom;

import java.util.List;

import entity.Products;
import entity.Users;
import entity.WishlistItem;

public interface wishListRepositoryCustom {
	public boolean existsByUserAndProduct(Users user, Products product);
	 List<WishlistItem> findByUser(Users user);
}
