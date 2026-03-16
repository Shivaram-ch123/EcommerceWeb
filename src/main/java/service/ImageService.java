package service;

import entity.Images;
import repository.ImageRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.Optional;

@Service
public class ImageService {

    @Autowired
    private ImageRepository imageRepository;

    /**
     * Get the first image for a given product ID
     * @param productId the product's id
     * @return Images object or null if not found
     */
    public Images getImageByProductId(Long productId) {
        Optional<Images> imageOpt = imageRepository.findByProductId(productId);
        return imageOpt.orElse(null);
    }
}