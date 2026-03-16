package RepoImplementation;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import RepositoryCustom.InformationRepositoyCustom;
import entity.Information;
import entity.Users;

@Repository
public class InformationRepositoryImpl implements InformationRepositoyCustom {
	@PersistenceContext
	private EntityManager entityManager;

	// Actual method to fetch Information by Users
	public Information findByUser(Users user) {
		String jpql = "SELECT i FROM Information i WHERE i.user = :user";
		Query query = entityManager.createQuery(jpql); // generic Query, not TypedQuery
		query.setParameter("user", user);

		try {
			return (Information) query.getSingleResult(); // cast to Information
		} catch (Exception e) {
			return null; // no Information found
		}
	}
}
