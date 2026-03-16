
package repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import RepositoryCustom.UserRepositoryCustom;
import RepositoryCustom.wishListRepositoryCustom;
import entity.Users;
import entity.WishlistItem;
@Repository
public interface wishlistRepository extends JpaRepository<WishlistItem, Integer> , wishListRepositoryCustom{  
	
	
}

