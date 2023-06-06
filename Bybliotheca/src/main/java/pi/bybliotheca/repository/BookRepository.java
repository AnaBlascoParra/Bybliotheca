package pi.bybliotheca.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pi.bybliotheca.entity.Book;

import java.io.Serializable;
import java.util.List;

public interface BookRepository extends JpaRepository<Book, Integer> {
    Book findByTitle(String title);
    Book findById(int id);
    List<Book> findByGenre(String genre);

    List<Book> findByAuthor(String author);

}
