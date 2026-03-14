package controllers;



import configuration.AppConfig;
import entity.Products;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;

public class Test {

    public static void main(String[] args) {
        // Bootstrap Spring context
        AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);

        // Get EntityManagerFactory and create EntityManager
        EntityManagerFactory emf = context.getBean(EntityManagerFactory.class);
        EntityManager em = emf.createEntityManager();

        // Begin transaction
        EntityTransaction tx = em.getTransaction();
        tx.begin();

        // Loop to add products
        for (int i = 1; i <= 10; i++) {
            Products product = new Products();
            product.setCategory("Laptops");
            product.setName("Dell Q" + (i*10+1));
            product.setCost(20.0 * i);
            product.setStock(70 + i);
            em.persist(product);  // persist inserts into table
        }

        // Commit transaction
        tx.commit();

        // Close EntityManager and context
        em.close();
        context.close();

        System.out.println("Products inserted successfully!");
    }
}