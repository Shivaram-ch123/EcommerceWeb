package controllers;

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
import service.ProductService;
import service.UserService;

@Controller
public class ProductController {
	@Autowired
	private ProductService productService;
	@Autowired
	private UserService userService;

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

		model.addAttribute("products", list);

		return "HomePage";
	}

	@GetMapping("/viewProduct")
	public String viewProduct(@RequestParam("productId") Long productId, Model model) {
		// Fetch the product from the database using a service
		Products product = productService.getProductById(productId);


		model.addAttribute("product", product);


		return "productView";
	}

}
