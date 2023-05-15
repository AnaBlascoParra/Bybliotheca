package pi.bybliotheca.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pi.bybliotheca.entity.BookFav;
import pi.bybliotheca.entity.Borrowing;

public interface BookFavRepository extends JpaRepository<BookFav, Integer> {

    BookFav findById(int id);

}
