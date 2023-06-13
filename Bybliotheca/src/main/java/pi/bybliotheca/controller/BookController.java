package pi.bybliotheca.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import pi.bybliotheca.entity.Book;
import pi.bybliotheca.entity.User;
import pi.bybliotheca.repository.BookRepository;
import pi.bybliotheca.repository.UserRepository;
import pi.bybliotheca.service.BookService;

import java.util.List;

@RestController
public class BookController {

    @Autowired
    private BookService service;

    @Autowired
    UserRepository userRepository;

    @Autowired
    BookRepository repository;

    @PostMapping("/books/addbook")
    public Book addBook(@RequestBody Book book){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN")) {
            return service.saveBook(book);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }

    @PutMapping("/books/updatebook")
    public Book updateBook(@RequestBody Book book){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN")) {
            return service.updateBook(book);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }

    @DeleteMapping("/books/deletebook/{title}")
    public void deleteBook(@PathVariable String title){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN")) {
            service.deleteByTitle(title);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }

    @GetMapping("/books")
    public List<Book> getBooks(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN") || loggedUser.getRole().equals("USER")) {
            return service.getBooks();
        } else {
            throw new SecurityException("Invalid operation");
        }
    }

    @GetMapping("/books/id/{id}")
    public Book getBook(@PathVariable int id){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN") || loggedUser.getRole().equals("USER")) {
            return service.getBookById(id);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }

    @GetMapping("/books/title/{title}")
    public Book getBook(@PathVariable String title){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN") || loggedUser.getRole().equals("USER")) {
            return service.getBookByTitle(title);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }

    @GetMapping("/books/author/{author}")
    public List<Book> getBooksByAuthor(@PathVariable String author){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN") || loggedUser.getRole().equals("USER")) {
            return service.getBooksByAuthor(author);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }

    @GetMapping("/books/genre/{genre}")
    public List<Book> getBooksByGenre(@PathVariable String genre){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN") || loggedUser.getRole().equals("USER")) {
            return service.getBooksByGenre(genre);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }

    @PutMapping("/books/title/{title}/addreview")
    public void writeReview(@PathVariable String title){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("USER")) {
            Book book = service.getBookByTitle(title);
            service.writeReview(book);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }



}



