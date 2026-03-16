
package repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import RepositoryCustom.InformationRepositoyCustom;
import entity.Information;
import entity.OrderItem;

@Repository
public interface InformationRepository extends JpaRepository<Information, Integer> ,InformationRepositoyCustom{
    // standard CRUD operations
}