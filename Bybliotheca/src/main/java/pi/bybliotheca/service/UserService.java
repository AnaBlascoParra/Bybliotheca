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
import pi.bybliotheca.entity.BookFav;
import pi.bybliotheca.entity.Borrowing;
import pi.bybliotheca.entity.User;
import pi.bybliotheca.repository.BookFavRepository;
import pi.bybliotheca.repository.BookRepository;
import pi.bybliotheca.repository.BorrowingRepository;
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
    private BorrowingRepository brRepository;

    @Autowired
    private BookFavRepository bfRepository;

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

    public User deleteUser(User user) {
        user.setActive(0);
        user.setDeleted(1);
        return repository.save(user);
    }

    public User updateUser(User user) {
        User existingUser = repository.findByUsername(user.getUsername());
        existingUser.setUsername(user.getUsername());
        existingUser.setEmail(user.getEmail());
        return repository.save(existingUser);
    }

    public void activateUser(User user) {
        if (user.getActive() == 0 && !user.getDni().isEmpty()) {
            user.setActive(1);
        } else {
            throw new SecurityException("Invalid operation. User " + user.getId() + "  has already been activated or hasn't properly filled the 'dni' field.");
        }
    }

    public User getUserById(int id) {
        return repository.findById(id);
    }

    public User getUserByUsername(String username) {
        return repository.findByUsername(username);
    }

    public List<Book> getBorrowedBooks(User user){
        List<Integer> bookIds = brRepository.findAll().stream()
                .filter(borrowing->borrowing.getUserId()==user.getId())
                .map(Borrowing::getBookId)
                .collect(Collectors.toList());
        List<Book> borrowedBooks = bookRepository.findAllById(bookIds);
        return borrowedBooks;
    }

    public List<Book> getFavedBooks(User user){
        List<Integer> bookIds = bfRepository.findAll().stream()
                .filter(bf->bf.getUserId()==user.getId())
                .map(BookFav::getBookId)
                .collect(Collectors.toList());
        List<Book> favedBooks = bookRepository.findAllById(bookIds);
        return favedBooks;
    }

    public List<User> getActiveUsers(){
        return repository.findAll().stream()
                .filter(x->x.getDeleted()==0)
                .collect(Collectors.toList());
    }



}
