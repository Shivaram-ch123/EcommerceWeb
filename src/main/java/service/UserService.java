package service;

import repository.*;
import repository.*;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import entity.*;
import repository.UserRepository;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository; // here we are getting the same instance every time
	@Autowired
	private CartItemsRepository cartItemsRepository;

	@Autowired
	private InformationRepository informationRepository;

	


	public void saveInformation(Information info) {
		informationRepository.save(info);
	}

	
	public Information getInformationByUser(entity.Users user) {
		return informationRepository.findByUser(user);
	}

	public void save(Users user) {
		userRepository.save(user);
	}

	public boolean registerUser(Users user) {
		
		boolean checkingIfUserExists = userRepository.userExistsByEmail(user.getEmail());
		if(checkingIfUserExists)return false;
		Users resultUser = userRepository.save(user);
		if (resultUser != null) {
			return true;
		}
		return false;
	}

	public boolean checkUserExists(String email, String password) {
		boolean result = userRepository.userExistanceByEmailAndPassword(email, password);
		return result;
	}

	public Users checkUserExistsReturn(String email, String password) {
		Users result = userRepository.userExistanceByEmailAndPasswordReturn(email, password);
		return result;
	}

	public String addToCart(Users user, int productId) {
		cartItemsRepository.addProductToCart(user.getId(), productId, 1);
		System.out.println("Success");
		return "Product added to cart successfully!";

	}

	public boolean updateUserProfile(Users updatedUser) {
		// Fetch the existing user from DB by ID
		Users existingUser = userRepository.findById(updatedUser.getId()).orElse(null);

		if (existingUser != null) {
			// Update the fields
			existingUser.setUserName(updatedUser.getUserName());
			existingUser.setEmail(updatedUser.getEmail());
			existingUser.setPhoneNumber(updatedUser.getPhoneNumber());

			// Save updated user back to DB
			userRepository.save(existingUser);
			return true;
		}

		return false; // User with given ID not found
	}

	public List<Users> getAllUsers() {
		return userRepository.findAll();
	}

}
