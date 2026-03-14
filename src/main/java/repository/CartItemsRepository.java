package repository;
import RepositoryCustom.*;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import RepositoryCustom.*;
import RepositoryCustom.UserRepositoryCustom;
import entity.CartItems;
import entity.Users;
@Repository
public interface CartItemsRepository extends JpaRepository<CartItems, Integer> , CartItemsRepositoryCustom{  
	
	
}