package entity;

import javax.persistence.*;

@Entity
public class Information {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String address;

    private String profileImageUrl = "/resources/images/pImage.jpg";
    @OneToOne
    @JoinColumn(name = "user_id", unique = true)
    private Users user;

    // Constructors
    public Information() {}

    public Information(String address, String profileImageUrl, Users user) {
        this.address = address;
        this.profileImageUrl = profileImageUrl;
        this.user = user;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getProfileImageUrl() { return profileImageUrl; }
    public void setProfileImageUrl(String profileImageUrl) { this.profileImageUrl = profileImageUrl; }

    public Users getUser() { return user; }
    public void setUser(Users user) { this.user = user; }
}