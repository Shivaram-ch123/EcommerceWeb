package service;
import repository.*;
import repository.*;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.entities.User;

import entity.Users;
import repository.UserRepository;


@Service
public class UserService {

    @Autowired
    private UserRepository userRepository; // here we are getting the same instance every time
    @Autowired
    private CartItemsRepository cartItemsRepository;

    public void save(Users user) {
        userRepository.save(user);
    }
    
    public boolean registerUser(Users user) {
    	// here this service will take care of the user services
    	Users resultUser = userRepository.save(user);
    	if(resultUser!=null) {
    		return true;
    	}
    	return false;
    }
    
    public boolean checkUserExists(String email,String password) {
    	boolean result =userRepository.userExistanceByEmailAndPassword(email,password);
    	return result;
    }
    public Users checkUserExistsReturn(String email,String password) {
    	Users result =userRepository.userExistanceByEmailAndPasswordReturn(email,password);
    	return result;
    }
    
    public String addToCart(Users user , int productId){
    	cartItemsRepository.addProductToCart(user.getId(),productId,1);
    	System.out.println("Success");
    	return "Product added to cart successfully!";
    	
    }
    
  
    
}
