package pi.bybliotheca.entity;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "BOOKS")

public class Book {
    @Id
    @GeneratedValue
    private int id;
    private String title;
    private String author;
    private String genre;
    private int npages;
    private int year;
    private int qty;
}
