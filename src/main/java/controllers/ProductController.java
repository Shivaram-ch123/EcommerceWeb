package controllers;

import java.util.*;
import entity.*;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entity.Products;
import entity.Users;
import service.ImageService;
import service.ProductService;
import service.UserService;

@Controller
public class ProductController {
	@Autowired
	private ProductService productService;
	@Autowired
	private UserService userService;
	@Autowired
	private ImageService imageService;

//	@PostMapping("/showCategory")
//	public String getProductsByCategory(String type,Model model) {
//		List<Products> list = productService.getProductsByCategory(type);
//		
//		model.addAttribute("listResult", list);
//		return "HomePage";
//	}

	@RequestMapping(value = "/showCategory")
	public String getProductsByCategory(@RequestParam("category") String type, Model model) {
		System.out.println("hi__________________________");
		List<Products> list;

		if (type == null || type.isEmpty()) {
			list = productService.getAllProducts(); // show all products
		} else {
			list = productService.getProductsByCategory(type); // filtered products
		}

		// Fetch image URLs for each product
		Map<Long, String> productImages = new HashMap<>();
		for (Products p : list) {
			try {
				Images img = imageService.getImageByProductId(p.getId()); // your service method
				if (img != null) {
					productImages.put(p.getId(), img.getUrl());
				} else {
					productImages.put(p.getId(), "/images/no-image.png"); // fallback image
				}
			} catch (Exception e) {
				e.printStackTrace();
				productImages.put(p.getId(), "/images/no-image.png");
			}
		}

		// Add products and their images to model
		model.addAttribute("products", list);
		model.addAttribute("productImages", productImages);

		return "HomePage";
	}

	@GetMapping("/viewProduct")
	public String viewProduct(@RequestParam("productId") Long productId, Model model) {
		// here i need to Fetch the product from the data base
		Products product = productService.getProductById(productId);
		Images image = imageService.getImageByProductId(productId);

		model.addAttribute("product", product);
		model.addAttribute("image",image);

		return "productView";
	}

}
