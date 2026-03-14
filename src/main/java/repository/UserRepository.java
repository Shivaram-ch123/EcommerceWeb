package repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import RepositoryCustom.UserRepositoryCustom;
import entity.Users;
@Repository
public interface UserRepository extends JpaRepository<Users, Integer> , UserRepositoryCustom{  

	
}

