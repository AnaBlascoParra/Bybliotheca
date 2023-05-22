package pi.bybliotheca.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;
import pi.bybliotheca.entity.User;
import pi.bybliotheca.repository.UserRepository;
import pi.bybliotheca.service.BorrowingService;

@RestController
public class BorrowingController {

    @Autowired
    private BorrowingService service;
    @Autowired
    private UserRepository userRepository;


    @PutMapping("/books/{id}/borrow")
    public void borrowBook(@PathVariable int id, int userId){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getId()==userId || loggedUser.getRole().equals("USER")) {
            service.borrowBook(id,userId);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }

    @PutMapping("/user/{userId}/borrowed/{id}/return")
    public void returnBook(@PathVariable int id, int userId){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getId()==userId || loggedUser.getRole().equals("USER")){
            service.returnBook(id);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }

}
