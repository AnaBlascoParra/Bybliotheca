package pi.bybliotheca.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pi.bybliotheca.entity.User;

public interface UserRepository extends JpaRepository<User,Integer> {
    User findById(int id);
    User findByFullname(String name, String surname);
}
