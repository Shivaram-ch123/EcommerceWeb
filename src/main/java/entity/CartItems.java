package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "cart_items")
public class CartItems {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

    @JoinColumn(name="productId")
    private int productId;
	private int quantity;

	@ManyToOne
	@JoinColumn(name = "user_id") // links to the user's id
	private Users user;

	// No-argument constructor (required by Hibernate)
	public CartItems() {
	}

	// Parameterized constructor
	public CartItems( int productId, int quantity, Users user) {
		this.productId = productId;
		this.quantity = quantity;
		this.user = user;
	}

	// Getters and Setters

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}
}