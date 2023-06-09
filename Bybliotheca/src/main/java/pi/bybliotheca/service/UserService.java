package pi.bybliotheca.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import pi.bybliotheca.entity.Book;
import pi.bybliotheca.entity.User;
import pi.bybliotheca.repository.BookRepository;
import pi.bybliotheca.repository.UserRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository repository;

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private BookService bookService;

    @Bean
    public BCryptPasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = repository.findByUsername(username);

        org.springframework.security.core.userdetails.User.UserBuilder builder = null;

        if (user != null) {
            builder = org.springframework.security.core.userdetails.User.withUsername(username);
            builder.disabled(false);
            builder.password(user.getPassword());
            builder.authorities(new SimpleGrantedAuthority(user.getRole()));

        } else
            throw new UsernameNotFoundException("User not found");
        return builder.build();
    }


    public User register(User user){
        user.setPassword(passwordEncoder().encode(user.getPassword()));
        user.setActive(1);
        user.setRole("USER");
        return repository.save(user);
    }
    public User saveUser(User user) {
        return repository.save(user);
    }

    public void deleteUser(String username) {
        User user = repository.findByUsername(username);
        user.setActive(0);
        user.setDeleted(1);
        repository.save(user);
    }

    public User updateUser(User user) {
        User existingUser = repository.findByUsername(user.getUsername());
        existingUser.setUsername(user.getUsername());
        existingUser.setEmail(user.getEmail());
        return repository.save(existingUser);
    }

    public User getUserById(int id) {
        return repository.findById(id);
    }

    public User getUserByUsername(String username) {
        return repository.findByUsername(username);
    }

    public List<User> getActiveUsers(){
        return repository.findAll().stream()
                .filter(x->x.getDeleted()==0)
                .collect(Collectors.toList());
    }



}
