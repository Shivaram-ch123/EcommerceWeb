package controllers;

import configuration.AppConfig;
import entity.Images;
import entity.Products;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;

public class Test {

    public static void main(String[] args) {
        // Bootstrap Spring context
        AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);

        EntityManagerFactory emf = context.getBean(EntityManagerFactory.class);
        EntityManager em = emf.createEntityManager();

        // Sample image URLs
        String[] imageUrls = {
            "https://m.media-amazon.com/images/I/61Qe0euJJZL.jpg",
            "https://media.wired.com/photos/67e5bd328eceed9f2cae96f3/4:3/w_640%2Cc_limit/Razer-Blade-16-2025-Laptop-(front)-Reviewer-Photo-SOURCE-Luke-Larsen.jpg",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXk5nRnRiAxI2WkwLLp-96eiS-kycDbiWfAw&s",
            "https://cdn.beebom.com/mobile/motorola-g57-front-and-back3.png",
            "https://cdn.mos.cms.futurecdn.net/Q8hjHr8JG7Yu36wce5jTT5.jpg",
            "https://cdn.tmobile.com/content/dam/t-mobile/en-p/cell-phones/Motorola/Motorola-moto-g-play-2026/PANTONE-Tapestry/Motorola-moto-g-play-2026-PANTONE-Tapestry-frontimage.png"
        };

        EntityTransaction tx = em.getTransaction();
        tx.begin();

        for (int i = 0; i < imageUrls.length; i++) {
            Products product = new Products();

            // Assign category
            if (i < 3) {
                product.setCategory("Laptops");
            } else {
                product.setCategory("Mobiles");
            }

            // Set basic fields
            product.setName("Dell Q" + ((i + 1) * 10 + 1));
            product.setCost(20.0 * (i + 1));
            product.setStock(70 + (i + 1));

            // Persist product
            em.persist(product);

            // Persist associated image with description
            Images image = new Images();
            image.setUrl(imageUrls[i]);
            image.setProduct(product);
            image.setDescription("High-quality " + product.getCategory() + " product."); // use Images.description
            em.persist(image);
        }

        tx.commit();
        em.close();
        context.close();

        System.out.println("Products and images inserted successfully with descriptions!");
    }
}