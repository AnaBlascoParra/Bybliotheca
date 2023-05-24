package pi.bybliotheca.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pi.bybliotheca.entity.Book;
import pi.bybliotheca.entity.Borrowing;

import java.io.Serializable;

public interface BorrowingRepository extends JpaRepository<Borrowing, Integer> {
    Borrowing findById(int id);
}
