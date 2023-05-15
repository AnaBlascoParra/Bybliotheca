package pi.bybliotheca.controller;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import pi.bybliotheca.entity.Book;
import pi.bybliotheca.entity.User;
import pi.bybliotheca.repository.UserRepository;
import pi.bybliotheca.service.UserService;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@RestController
public class UserController {

    @Autowired
    private UserService service;

    @Autowired
    private UserRepository repository;

    @Autowired
    private AuthenticationManager authenticationManager;


    @PostMapping("/register") //TO-DO: Security - Email/username/dni duplicado
    public User register(@RequestBody User user){
        return service.register(user);
    }

    /*@PostMapping("/register") ?????
    public User Register(@RequestBody User user) {
        return repository.save(user);
    }*/

    @PostMapping("/login")
    public User login(@RequestParam("user") String username, @RequestParam("password") String password){
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(username,password));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        User user = service.getUserByUsername(username);
        String token = getJWTToken(username);
        if(user.getActive()==1 && user.getDeleted()==0) {
            user.setToken(token);
            return user;
        } else {
            throw new SecurityException("Invalid operation: User " + user.getId() + " deleted or not yet activated by ADMIN.");
        }
    }

    /*@PostMapping("/login") ?????
    public User Login(@RequestBody User user) {
        User oldUser = repository.findByUsername(user.getUsername());
        return oldUser;
    }*/

    private String getJWTToken(String username){
        String secretKey = "mySecretKey";
        List<GrantedAuthority> grantedAuthorities = AuthorityUtils
                .commaSeparatedStringToAuthorityList("USER, ADMIN");
        String token = Jwts.builder()
                .setId("softtekJWT")
                .setSubject(username)
                .claim("authorities", grantedAuthorities.stream()
                        .map(GrantedAuthority::getAuthority)
                        .collect(Collectors.toList()))
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis()+600000))
                .signWith(SignatureAlgorithm.HS512,secretKey.getBytes()).compact();
        return "Bearer " + token;
    }

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
