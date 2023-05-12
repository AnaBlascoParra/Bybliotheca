package pi.bybliotheca.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "USERS")
public class User {

    @Id
    @GeneratedValue
    private int id;
    private String username;
    private String dni;
    private String email;
    private String password;
    private String name;
    private String surname;
    private List<Book> borrowed;
    private List<Book> favourites;

    public void addBorrowedBook(Book book, int id) { //!!: pasar a Java8
        for (Book b : this.borrowed) {
            if (b.getId() == book.getId()) {
                throw new ArithmeticException("You can't borrow more than one copy of the same book.");
            } else {
                this.borrowed.add(book);
            }
        }
    }

    public void addFavBook(Book book, int id){ //!!: pasar a Java8
        for (Book b : this.favourites) {
            if (b.getId() == book.getId()) {
                throw new ArithmeticException("You already added '" + book.getTitle() +"' to your 'Favourites'." );
            } else {
                this.favourites.add(book);
            }
        }
    }

}
