package pi.bybliotheca.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import pi.bybliotheca.entity.User;
import pi.bybliotheca.repository.UserRepository;
import pi.bybliotheca.service.UserService;

import java.util.List;

@RestController
public class AdminController {

    @Autowired
    private UserService service;

    @Autowired
    private UserRepository repository;
    @PutMapping("users/deleteuser")
    public void deleteUser(@RequestBody User user){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = repository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN")) {
            service.deleteUser(user);
        } else {
            throw new SecurityException("Invalid operation.");
        }
    }

    @PutMapping("/users/activateUser")
    public void activate(@RequestBody User user){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = repository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN")) {
            service.activateUser(user);
        } else {
            throw new SecurityException("Invalid operation.");
        }
    }

    @GetMapping("/users")
    public List<User> getUsers(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = repository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN")) {
            return service.getActiveUsers();
        } else {
            throw new SecurityException("Invalid operation.");
        }
    }


}
