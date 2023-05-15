package pi.bybliotheca.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import pi.bybliotheca.entity.Book;
import pi.bybliotheca.entity.User;
import pi.bybliotheca.repository.UserRepository;
import pi.bybliotheca.service.UserService;

@RestController
public class UserController {

    @Autowired
    private UserService service;

    @Autowired
    private UserRepository repository;

    //TO-DO: Register

    //TO-DO: Login

    @PutMapping("/updateUser")
    public User updateUser(@RequestBody User user){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = repository.findByUsername(auth.getPrincipal().toString());
        if(loggedUser.getId()==user.getId()) {
            return service.updateUser(user);
        } else {
            throw new SecurityException("Invalid operation");
        }
    }

    @GetMapping("/users/{id}")
    public User profile(@PathVariable int id){
        return service.getUserById(id);
    }

    //??: tengo que hacer un endpoint para /users/{dni} también? creo que no, porque si busco *hipoteticamente* en la barra de busqueda de la app un dni me sale el
    // usuario y le doy click y cuando muestra su perfil es a traves de la id, que la coge, pero no sé cómo manejar eso

    //TO-DO: FAVOURITES

    //TO-DO: BORROWED


}
