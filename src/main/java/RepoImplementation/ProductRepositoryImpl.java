package RepoImplementation;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import RepositoryCustom.ProductRepositoryCustom;
import entity.Products;
@Repository
public class ProductRepositoryImpl implements ProductRepositoryCustom{

    @PersistenceContext
    private EntityManager entityManager;

    public List<Products> getProducts(String type) {

        String jpql = "SELECT p FROM Products p WHERE p.category = :type";

        List<Products> products = entityManager
                .createQuery(jpql, Products.class)
                .setParameter("type", type)
                .getResultList();

        return products;
    }
}