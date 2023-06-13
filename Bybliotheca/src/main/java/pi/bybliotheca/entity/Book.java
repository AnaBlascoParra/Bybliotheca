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

    private List<Long> reviews;

    private List<Integer> ratings;

    private double avrRating;


    public Book(String title, String author, String summary, String genre, int npages, int year, int qty) {
        this.title = title;
        this.author = author;
        this.summary = summary;
        this.genre = genre;
        this.npages = npages;
        this.year = year;
        this.qty = qty;
    }

    public double calculateAvrRating(){
        int ratingSum = this.ratings.stream()
                .mapToInt(Integer::intValue)
                .sum();
        double avrRating = (double) ratingSum/this.ratings.size();
        return avrRating;

    }
}
