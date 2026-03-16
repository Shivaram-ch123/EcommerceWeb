package RepositoryCustom;

import org.springframework.stereotype.Repository;

import entity.Information;
import entity.Users;

@Repository
public interface InformationRepositoyCustom {
	Information findByUser(Users user);
}
