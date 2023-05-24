package pi.bybliotheca.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pi.bybliotheca.entity.Book;

import java.io.Serializable;

public interface BookRepository extends JpaRepository<Book, Integer> {
    Book findByTitle(String title);
    Book findById(int id);
}
