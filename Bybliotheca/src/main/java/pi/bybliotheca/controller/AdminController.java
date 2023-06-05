package pi.bybliotheca.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import pi.bybliotheca.entity.User;
import pi.bybliotheca.repository.UserRepository;
import pi.bybliotheca.service.UserService;

@RestController
public class AdminController {

    @Autowired
    private UserService service;

    @Autowired
    private UserRepository repository;
    @DeleteMapping("/deleteUser/{id}")
    public void deleteUser(@PathVariable int id){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = repository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN")) {
            service.deleteUser(id);
        } else {
            throw new SecurityException("Invalid operation.");
        }
    }

    @PutMapping("/activateUser")
    public void activate(@RequestBody User user){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = repository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole().equals("ADMIN")) {
            service.activateUser(user);
        } else {
            throw new SecurityException("Invalid operation.");
        }
    }


}
