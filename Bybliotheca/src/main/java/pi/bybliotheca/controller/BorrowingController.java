package pi.bybliotheca.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import pi.bybliotheca.entity.Book;
import pi.bybliotheca.entity.User;
import pi.bybliotheca.repository.UserRepository;
import pi.bybliotheca.service.BorrowingService;

import java.util.List;

@RestController
public class BorrowingController {

    @Autowired
    private BorrowingService service;
    @Autowired
    private UserRepository userRepository;


    @PostMapping("/books/title/{bookTitle}/borrow/{userId}")
    public void borrowBook(@PathVariable String bookTitle, int userId){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("USER")) {
            service.borrowBook(bookTitle,userId);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }

    @PutMapping("/user/id/{userId}/borrowed/{brId}/return")
    public void returnBook(@PathVariable int brId, int userId){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getId()==userId || loggedUser.getRole().equals("USER")){
            service.returnBook(brId);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }

    @GetMapping("users/id/{userId}/borrowed")
    public List<Book> getBorrowedBooks(@PathVariable int userId){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN") || loggedUser.getRole().equals("USER")) {
            return service.getBorrowedBooks(userId);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }

}
