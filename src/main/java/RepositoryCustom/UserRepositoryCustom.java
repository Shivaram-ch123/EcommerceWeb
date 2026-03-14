package RepositoryCustom;

import java.util.List;

import org.springframework.stereotype.Repository;

import entity.CartItems;
import entity.Users;
@Repository
public interface UserRepositoryCustom {
	public boolean userExistanceByEmailAndPassword(String email, String password);

	public Users userExistanceByEmailAndPasswordReturn(String email, String password);

	
}
