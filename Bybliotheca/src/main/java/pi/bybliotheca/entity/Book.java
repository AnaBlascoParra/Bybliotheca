package pi.bybliotheca.entity;


import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

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
