package pi.bybliotheca.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import pi.bybliotheca.entity.Book;
import pi.bybliotheca.service.BookService;

import java.util.List;

@RestController
public class BookController {

    @Autowired
    private BookService service;

    @PostMapping("/addBook")
    public Book addBook(@RequestBody Book book){
        return service.saveBook(book);
    }

    @PutMapping("/updateBook")
    public Book updateBook(@RequestBody Book book){
        return service.updateBook(book);
    }

    @DeleteMapping("/deleteBook/{id}")
    public String deleteBook(@PathVariable int id){
        return service.deleteBook(id);
    }

    @GetMapping("/books")
    public List<Book> getBooks(){
        return service.getBooks();
    }

    @GetMapping("/books/{author}")
    public List<Book> getBooksByAuthor(@PathVariable String author){
        return service.getBooksByAuthor(author);
    }

    @GetMapping("/books/{genre}")
    public List<Book> getBooksByGenre(@PathVariable String genre){
        return service.getBooksByGenre(genre);
    }



}
