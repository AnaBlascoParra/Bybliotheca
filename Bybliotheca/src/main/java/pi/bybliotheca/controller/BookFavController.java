package pi.bybliotheca.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import pi.bybliotheca.entity.BookFav;
import pi.bybliotheca.entity.User;
import pi.bybliotheca.repository.UserRepository;
import pi.bybliotheca.service.BookFavService;

@RestController
public class BookFavController {

    @Autowired
    private BookFavService service;

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/books/{id}/addFav")                     //??: tengo que tener en cuenta de alguna forma que esta operacion se hace una vez en el perfil de un libro,
    public BookFav addBookToFavs(@PathVariable int id){    // o eso ya es en el front poniendo el boton correspondiente en la pantalla que sea?
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole()=="USER"){
            return service.addBookToFavs(id);
        } else {
            throw new SecurityException("Invalid operation.");
        }
    }

    @DeleteMapping("/users/{userId}/favourites/{id}/removeFav")
    public void removeFromFavs(@PathVariable int userId, int id){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getRole()=="USER"){
            service.removeBookFromFavs(id);
        } else {
            throw new SecurityException("Invalid operation.");
        }
    }


}
