package RepositoryCustom;

import java.util.List;

import org.springframework.stereotype.Repository;

import entity.Orders;
import entity.Users;

@Repository
public interface OrderRepositoryCustom {
	 public List<Orders> getRowsUserId(Users user);
}
