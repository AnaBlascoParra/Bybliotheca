package pi.bybliotheca.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pi.bybliotheca.entity.User;

import java.io.Serializable;

public interface UserRepository extends JpaRepository<User, Serializable> {
    User findById(int id);

    User findByUsername(String username);

    User findByDni(String dni);
}
