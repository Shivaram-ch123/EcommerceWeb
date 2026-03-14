package entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity

public class Users {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String userName;
	private String password;
	private String phoneNumber;
	private String email;

	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private List<CartItems> carts = new ArrayList<CartItems>();

	public int getId() {
		return id;
	}

	public List<CartItems> getCarts() {
		return carts;
	}

	public void setCarts(List<CartItems> carts) {
		this.carts = carts;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Users(String userName, String password, String phoneNumber, String email) {
		super();
		this.userName = userName;
		this.password = password;
		this.phoneNumber = phoneNumber;
		this.email = email;
	}

	public Users() {
		super();
		// TODO Auto-generated constructor stub
	}

}