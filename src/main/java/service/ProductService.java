package service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import entity.Products;
import repository.ProductRepository;
import repository.UserRepository;

@Service
public class ProductService {

	@Autowired
	private ProductRepository productRepository;

	public List<Products> getProductsByCategory(String type) {
		return productRepository.getProducts(type);
	}

	public List<Products> getAllProducts() {
		return productRepository.findAll();
	}

	// Method to get a product by ID
	public Products getProductById(Long productId) {
		Optional<Products> productOpt = productRepository.findById(productId);
		if (productOpt.isPresent()) {
			return productOpt.get();
		} else {
			throw new RuntimeException("Product not found with ID: " + productId);
		}
	}

}
