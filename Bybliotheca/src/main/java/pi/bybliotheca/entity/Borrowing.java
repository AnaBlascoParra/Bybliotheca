package pi.bybliotheca.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.LocalDate;

@Data
@NoArgsConstructor
@Entity
@Table(name="BORROWINGS")
public class Borrowing {
    @Id
    @GeneratedValue
    private int id;
    private int userId;
    private int bookId;
    private LocalDate borrowDate;
    private LocalDate returnDate;

    public Borrowing(int userId, int bookId, LocalDate borrowDate, LocalDate returnDate) {
        this.userId = userId;
        this.bookId = bookId;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
    }

    public LocalDate getBorrowDate() {
        return LocalDate.now();
    }
    public LocalDate getReturnDate() {
        return getBorrowDate().plusDays(15);
    }


}
