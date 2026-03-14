package RepoImplementation;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.entities.Cart_Items;

import RepositoryCustom.CartItemsRepositoryCustom;
import entity.CartItems;
import entity.Products;
import entity.Users;

@Repository
public class CartItemsRepositoryImpl implements CartItemsRepositoryCustom {
	@PersistenceContext
	private EntityManager em;

	@Transactional
	@Override
	public void addProductToCart(int userId, int productId, int quantity) {

		// Fetch the user
		Users user = em.find(Users.class, userId);
		if (user == null) {
			throw new RuntimeException("User with ID " + userId + " not found.");
		}

		// Check if product already exists in cart (classic for-loop)
		CartItems existingItem = null;
		for (CartItems c : user.getCarts()) {
			if (c.getProductId() == productId) {
				existingItem = c;
				break;
			}
		}

		if (existingItem != null) {
			// Increment quantity if already in cart
			existingItem.setQuantity(existingItem.getQuantity() + quantity);
			em.merge(existingItem);
		} else {
			// Create new CartItems
			CartItems cartItem = new CartItems(productId, quantity, user);
			user.getCarts().add(cartItem);
			em.persist(cartItem);
		}
	}

	public List<CartItems> getCartItemsByUserId(int userId) {

		// EntityManager em = emf.createEntityManager();

		String jpql = "SELECT c FROM CartItems c WHERE c.user.id = :uid";
		List<CartItems> list = em.createQuery(jpql, CartItems.class).setParameter("uid", userId).getResultList();
		return list;

	}

	@Transactional
	@Override
	public CartItems findByUserIdAndProductId(int userId, int productId) {
		String jpql = "SELECT c FROM CartItems c WHERE c.user.id = :userId AND c.productId = :productId";
		Query query = em.createQuery(jpql);
		query.setParameter("userId", userId);
		query.setParameter("productId", productId);

		try {
			return (CartItems) query.getSingleResult();
		} catch (Exception e) {
			return null; // Return null if no cart item found
		}
	}
}
