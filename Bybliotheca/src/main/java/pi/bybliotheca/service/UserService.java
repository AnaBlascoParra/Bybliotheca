package pi.bybliotheca.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import pi.bybliotheca.entity.Book;
import pi.bybliotheca.entity.BookFav;
import pi.bybliotheca.entity.Borrowing;
import pi.bybliotheca.entity.User;
import pi.bybliotheca.repository.BookFavRepository;
import pi.bybliotheca.repository.BookRepository;
import pi.bybliotheca.repository.BorrowingRepository;
import pi.bybliotheca.repository.UserRepository;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class UserService {

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

    public User saveUser(User user) {
        return repository.save(user);
    }

    public void deleteUser(int id) {
        User user = repository.findById(id);
        user.setActive(0);
        user.setDeleted(1);
        System.out.print("User successfully deleted.");
    }

    public User updateUser(User user) {
        User existingUser = repository.findById(user.getId());
        existingUser.setUsername(user.getUsername());
        existingUser.setEmail(user.getEmail());
        existingUser.setPassword(user.getPassword());
        existingUser.setName(user.getName());
        existingUser.setSurname(user.getSurname());
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

    public User getUserByDni(String dni) {
        return repository.findByDni(dni);
    }

    public List<Book> getBorrowedBooks(User user){
        List<Integer> bookIds = brRepository.findAll().stream()
                .filter(borrowing->borrowing.getUserId()==user.getId())
                .map(Borrowing::getBookId)
                .collect(Collectors.toList());
        List<Book> borrowedBooks = bookRepository.findAllById(bookIds);
        return borrowedBooks;
    }

    List<Book> getFavedBooks(User user){
        List<Integer> bookIds = bfRepository.findAll().stream()
                .filter(bf->bf.getUserId()==user.getId())
                .map(BookFav::getBookId)
                .collect(Collectors.toList());
        List<Book> favedBooks = bookRepository.findAllById(bookIds);
        return favedBooks;
    }


}
