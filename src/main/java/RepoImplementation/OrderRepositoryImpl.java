package RepoImplementation;

import entity.*;
import java.util.*;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import RepositoryCustom.OrderRepositoryCustom;

@Repository
public class OrderRepositoryImpl implements OrderRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Orders> getRowsUserId(Users user) {
        String jpql = "SELECT o FROM Orders o WHERE o.user = :user ORDER BY o.id";

        return entityManager.createQuery(jpql, Orders.class)
                .setParameter("user", user)
                .getResultList();
    }
}