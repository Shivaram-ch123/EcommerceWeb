package repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import RepositoryCustom.OrderRepositoryCustom;
import RepositoryCustom.ProductRepositoryCustom;
import entity.Orders;
import entity.Products;
@Repository
public interface OrderRepository extends JpaRepository<Orders, Integer> , OrderRepositoryCustom{
	
}
