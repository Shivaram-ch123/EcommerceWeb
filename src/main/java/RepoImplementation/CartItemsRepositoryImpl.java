package RepoImplementation;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import RepositoryCustom.CartItemsRepositoryCustom;
import entity.CartItems;
import entity.Products;
import entity.Users;

@Repository 
@Transactional
public class CartItemsRepositoryImpl implements CartItemsRepositoryCustom {
    @PersistenceContext
    private EntityManager em;

    @Override
    public void addProductToCart(int userId, int productId, int quantity) {

        Users user = em.find(Users.class, userId);
        Products product = em.find(Products.class, (long) productId);

        String jpql = "SELECT c FROM CartItems c WHERE c.user.id = :userId AND c.product.id = :productId ORDER BY c.id";

        List<CartItems> list = em.createQuery(jpql, CartItems.class)
                .setParameter("userId", userId)
                .setParameter("productId", (long) productId)
                .getResultList();

        if (!list.isEmpty()) {
            CartItems existing = list.get(0);
            existing.setQuantity(existing.getQuantity() + quantity);
        } else {
            CartItems cartItem = new CartItems(product, quantity, user);
            em.persist(cartItem);
        }
    }

    @Override
    public List<CartItems> getCartItemsByUserId(int userId) {
        String jpql = "SELECT c FROM CartItems c WHERE c.user.id = :uid ORDER BY c.id";
        List<CartItems> list = em.createQuery(jpql, CartItems.class)
                                 .setParameter("uid", userId)
                                 .getResultList();
        return list;
    }

    @Transactional
    @Override
    public CartItems findByUserIdAndProductId(int userId, int productId1) {
        long productId = productId1;
        String jpql = "SELECT c FROM CartItems c WHERE c.user.id = :userId AND c.product.id = :productId ORDER BY c.id";
        Query query = em.createQuery(jpql);
        query.setParameter("userId", userId);
        query.setParameter("productId", productId);

        try {
            return (CartItems) query.getSingleResult();
        } catch (Exception e) {
            return null; // Return null if no cart item found
        }
    }

    @Override
    public int getQuantityByUserIdAndProductId(Users user, Long productId) {
        String jpql = "SELECT c.quantity FROM CartItems c WHERE c.user = :user AND c.product.id = :productId ORDER BY c.id";
        try {
            return em.createQuery(jpql, Integer.class)
                     .setParameter("user", user)
                     .setParameter("productId", productId.intValue())
                     .getSingleResult();
        } catch (Exception e) {
            return 0;
        }
    }
}