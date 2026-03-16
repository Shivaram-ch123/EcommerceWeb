package repository;

import entity.Images;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import RepositoryCustom.ImageRepositporyCustom;

import java.util.Optional;

@Repository
public interface ImageRepository extends JpaRepository<Images, Long> ,ImageRepositporyCustom{
    
}