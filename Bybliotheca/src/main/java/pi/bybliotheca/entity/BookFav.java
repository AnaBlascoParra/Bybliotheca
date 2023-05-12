package pi.bybliotheca.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@NoArgsConstructor
@Entity
@Table(name="FAVS")
public class BookFav {
    @Id
    @GeneratedValue
    private int id;
    private int userId;
    private int bookId;

    public BookFav(int bookId,int userId) {
        this.bookId = bookId;
        this.userId = userId;
    }
}