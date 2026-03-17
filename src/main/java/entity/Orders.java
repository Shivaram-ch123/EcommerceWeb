package entity;

import java.time.LocalDate;
import java.util.List;
import javax.persistence.*;

@Entity
public class Orders {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private Users user;

	@OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
	private List<OrderItem> products;

	private LocalDate dateOfDelivery;
	private String address;
	private String paymentMode;

	@Column(nullable = false)
	private double totalAmount = 0;

	// Default Constructor
	public Orders() {
	}

	// Constructor
	public Orders(Users user, List<OrderItem> products, LocalDate dateOfDelivery, String address, String paymentMode,
			double totalAmount) {
		this.user = user;
		this.products = products;
		this.dateOfDelivery = dateOfDelivery;
		this.address = address;
		this.paymentMode = paymentMode;
		this.totalAmount = totalAmount;
	}

	// Getters and Setters

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

	public List<OrderItem> getProducts() {
		return products;
	}

	public void setProducts(List<OrderItem> products) {
		this.products = products;
	}

	public LocalDate getDateOfDelivery() {
		return dateOfDelivery;
	}

	public void setDateOfDelivery(LocalDate dateOfDelivery) {
		this.dateOfDelivery = dateOfDelivery;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPaymentMode() {
		return paymentMode;
	}

	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
}