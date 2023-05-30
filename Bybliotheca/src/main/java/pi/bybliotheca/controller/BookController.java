package pi.bybliotheca.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import pi.bybliotheca.entity.Book;
import pi.bybliotheca.entity.User;
import pi.bybliotheca.repository.UserRepository;
import pi.bybliotheca.service.BookService;
import pi.bybliotheca.service.BorrowingService;

import java.util.List;

@RestController
public class BookController {

    @Autowired
    private BookService service;

    @Autowired
    UserRepository userRepository;

    @PostMapping("/addBook")
    public Book addBook(@RequestBody Book book){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN")) {
            return service.saveBook(book);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }

    @PutMapping("/updateBook")
    public Book updateBook(@RequestBody Book book){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN")) {
            return service.updateBook(book);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }

    @DeleteMapping("/deleteBook/{id}")
    public void deleteBook(@PathVariable int id){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN")) {
            service.deleteBook(id);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }



    @GetMapping("/books")
    public List<Book> getBooks(){
        return service.getBooks();
    }

    @GetMapping("/authors")
    public List<String> getAuthors(){
        return service.getAuthors();
    }

    @GetMapping("/genres")
    public List<String> getGenres(){
        return service.getGenres();
    }

    @GetMapping("/books/{id}")
    public Book getBook(@PathVariable int id){
        return service.getBookById(id);
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



