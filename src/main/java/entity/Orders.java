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
    @JoinColumn(name = "user_id") // foreign key column
    private Users user;

    @ManyToMany
    @JoinTable(
        name = "order_products", // join table name
        joinColumns = @JoinColumn(name = "order_id"),
        inverseJoinColumns = @JoinColumn(name = "product_id")
    )
    private List<Products> products;

    private LocalDate dateOfDelivery;
    private String address;
    private String paymentMode;

    // Constructors
    public Orders() {}

    public Orders(Users user, List<Products> products, LocalDate dateOfDelivery, String address, String paymentMode) {
        this.user = user;
        this.products = products;
        this.dateOfDelivery = dateOfDelivery;
        this.address = address;
        this.paymentMode = paymentMode;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Users getUser() { return user; }
    public void setUser(Users user) { this.user = user; }

    public List<Products> getProducts() { return products; }
    public void setProducts(List<Products> products) { this.products = products; }

    public LocalDate getDateOfDelivery() { return dateOfDelivery; }
    public void setDateOfDelivery(LocalDate dateOfDelivery) { this.dateOfDelivery = dateOfDelivery; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPaymentMode() { return paymentMode; }
    public void setPaymentMode(String paymentMode) { this.paymentMode = paymentMode; }
}