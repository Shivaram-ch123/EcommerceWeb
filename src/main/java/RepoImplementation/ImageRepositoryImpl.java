package RepoImplementation;

import RepositoryCustom.ImageRepositporyCustom;
import entity.Images;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.Optional;

public class ImageRepositoryImpl implements ImageRepositporyCustom {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Optional<Images> findByProductId(Long productId) {
        String jpql = "SELECT i FROM Images i WHERE i.product.id = :pid";
        TypedQuery<Images> query = em.createQuery(jpql, Images.class);
        query.setParameter("pid", productId);
        query.setMaxResults(1); // only one image per product
        Images result = null;
        try {
            result = query.getSingleResult();
        } catch (Exception e) {
            // No result found
        }
        return Optional.ofNullable(result);
    }
}