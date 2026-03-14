package entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "products")
public class Products {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "name", nullable = false, length = 100)
	private String name;

	@Column(name = "cost", nullable = false)
	private Double cost;

	@Column(name = "stock", nullable = false)
	private Integer stock;

	@Column(name = "category", nullable = false, length = 50)
	private String category;



	// Default constructor
	public Products() {
	}

	// Constructor with all fields except id
	public Products(String name, Double cost, Integer stock, String category) {
		this.name = name;
		this.cost = cost;
		this.stock = stock;
		this.category = category;
	}

	// Getters and Setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Double getCost() {
		return cost;
	}

	public void setCost(Double cost) {
		this.cost = cost;
	}

	public Integer getStock() {
		return stock;
	}

	public void setStock(Integer stock) {
		this.stock = stock;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	@Override
	public String toString() {
		return "Products{" + "id=" + id + ", name='" + name + '\'' + ", cost=" + cost + ", stock=" + stock
				+ ", category='" + category + '\'' + '}';
	}
}