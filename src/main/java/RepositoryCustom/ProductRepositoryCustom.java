package RepositoryCustom;

import java.util.List;

import entity.Products;

public interface ProductRepositoryCustom {
	 public List<Products> getProducts(String type);
}
