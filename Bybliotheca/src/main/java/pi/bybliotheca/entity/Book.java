package pi.bybliotheca.entity;


import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@Entity
@Table(name = "BOOKS")

public class Book {
    @Id
    @GeneratedValue
    private int id;
    private String title;
    private String author;
    private String summary;
    private String genre;
    private int npages;
    private int year;
    private int qty;

    private String img;

    public Book(String title, String author, String summary, String genre, int npages, int year, int qty) {
        this.title = title;
        this.author = author;
        this.summary = summary;
        this.genre = genre;
        this.npages = npages;
        this.year = year;
        this.qty = qty;
    }
}
