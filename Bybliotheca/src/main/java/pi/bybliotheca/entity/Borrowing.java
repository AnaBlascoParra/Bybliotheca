package pi.bybliotheca.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name="BORROWINGS")
public class Borrowing {
    @Id
    @GeneratedValue
    private int id;
    private int userId;
    private int bookId;
    private LocalDateTime borrowDate;
    private LocalDateTime returnDate;

    public LocalDateTime getReturnDate() {
        return borrowDate.plusDays(15);
    }
}
