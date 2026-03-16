package RepoImplementation;

import RepositoryCustom.wishListRepositoryCustom;
import entity.Products;
import entity.Users;
import entity.WishlistItem;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

@Repository
public class wishlistRepositoryImpl implements wishListRepositoryCustom {

	@PersistenceContext
	private EntityManager entityManager;

	@Override
	public boolean existsByUserAndProduct(Users user, Products product) {
		String jpql = "SELECT COUNT(w) FROM WishlistItem w WHERE w.user = :user AND w.product = :product";
		Query query = entityManager.createQuery(jpql);
		query.setParameter("user", user);
		query.setParameter("product", product);

		Long count = (Long) query.getSingleResult();
		return count > 0;
	}

	@Override
	public List<WishlistItem> findByUser(Users user) {
		// Use a plain Query instead of TypedQuery
		String jpql = "SELECT w FROM WishlistItem w WHERE w.user = :user";
		Query query = entityManager.createQuery(jpql); // plain Query
		query.setParameter("user", user);

		// The result is a raw List, so cast it to List<WishlistItem>
		List<WishlistItem> wishlistItems = query.getResultList();
		return wishlistItems;
	}
}