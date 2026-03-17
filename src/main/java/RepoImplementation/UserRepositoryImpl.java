package RepoImplementation;

import entity.*;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import RepositoryCustom.UserRepositoryCustom;
import entity.Users;

@Repository
public class UserRepositoryImpl implements UserRepositoryCustom {
	// we need to get the helper that
	@PersistenceContext
	private EntityManager entityManager;

	@Override
	public boolean userExistanceByEmailAndPassword(String email, String password) {
		// crating a querry
		String jpql = "SELECT u FROM Users u WHERE u.email = :email AND u.password = :password ORDER BY u.id";
		List<Users> list = entityManager.createQuery(jpql, Users.class).setParameter("email", email)
				.setParameter("password", password).getResultList();

		if (list.size() > 0)
			return true;
		System.out.println("hi");
		return false;

	}

	@Override
	public Users userExistanceByEmailAndPasswordReturn(String email, String password) {
		// crating a querry
		String jpql = "SELECT u FROM Users u WHERE u.email = :email AND u.password = :password ORDER BY u.id";
		List<Users> list = entityManager.createQuery(jpql, Users.class).setParameter("email", email)
				.setParameter("password", password).getResultList();

		if (list.size() > 0)
			return list.get(0);
		System.out.println("hi");
		return null;

	}

	@Override
	public boolean userExistsByEmail(String email) {
		String jpql = "SELECT u FROM Users u WHERE u.email = :email";
		List<Users> list = entityManager.createQuery(jpql, Users.class).setParameter("email", email).getResultList();
		return !list.isEmpty(); // returns true if user exists
	}
}
