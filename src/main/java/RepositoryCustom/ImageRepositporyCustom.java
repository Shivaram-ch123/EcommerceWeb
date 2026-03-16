package RepositoryCustom;

import java.util.Optional;

import org.springframework.stereotype.Repository;

import entity.Images;

@Repository
public interface ImageRepositporyCustom {
	Optional<Images> findByProductId(Long productId);
}
