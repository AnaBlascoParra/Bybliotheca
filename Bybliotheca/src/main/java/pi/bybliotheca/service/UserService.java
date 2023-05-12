package pi.bybliotheca.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import pi.bybliotheca.entity.Book;
import pi.bybliotheca.entity.BookFav;
import pi.bybliotheca.entity.Borrowing;
import pi.bybliotheca.entity.User;
import pi.bybliotheca.repository.BookRepository;
import pi.bybliotheca.repository.UserRepository;

import java.time.LocalDate;

@Service
public class UserService {

    @Autowired
    private UserRepository repository;
    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private BookService bookService;

    public User saveUser(User user) {
        return repository.save(user);
    }

    public void deleteUser(int id) {
        repository.deleteById(id);
        System.out.print("User deleted");
    }

    public User updateUser(User user) { //??: no estoy segura de que el update deba devolver un User
        User existingUser = repository.findById(user.getId()); //orElse(null)?
        existingUser.setEmail(user.getEmail());
        existingUser.setPassword(user.getPassword());
        existingUser.setName(user.getName());
        existingUser.setSurname(user.getSurname());
        return repository.save(existingUser);
    }

    public User getUserById(int id) {
        return repository.findById(id); //orElse(null)?
    }

    public User getUserByUsername(String username) {
        return repository.findByUsername(username); //orElse(null)?
    }

    public User getUserByDni(String dni) {
        return repository.findByDni(dni);
    }



    /*public void addToFavourites(int bookId, int userId){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = repository.findById(userId);
        User loggedUser = repository.findByUsername(auth.getPrincipal().toString());
        Book book = bookRepository.findById(bookId);
        if(loggedUser.getId()==userId){
            user.addFavBook(book,userId); //??: aquí llamo al método de la entity, no de este service, no?
            BookFav newFavBook = new BookFav(bookId,userId);
            repository.save(user);
            System.out.print("Book added to 'Favourites': " + book.getTitle() + " by " + book.getAuthor());
        } else {
            throw new SecurityException("You are not correctly logged. Logging you out ...");
        }
    }*/




}
