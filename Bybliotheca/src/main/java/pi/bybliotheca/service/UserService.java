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

    public void addBorrowedBook(Book book, int userId){ //??: misma duda que en el de abajo
        User existingUser = repository.findById(userId);
        existingUser.addBorrowedBook(book,userId);
        repository.save(existingUser);
    }

    public void addFavBook(Book book, int userId){ //??: no estoy segura del proposito de este metodo en el service, si luego abajo no lo llamo, no debería quedarse en la entity? no me entero
        User existingUser = repository.findById(userId);
        existingUser.addFavBook(book,userId);
        repository.save(existingUser);
    }

    public User getUserById(int id) {
        return repository.findById(id); //orElse(null)?
    }

    public User getUserByUsername(String username) {
        return repository.findByUsername(username); //orElse(null)?
    }

    public User getUserByFullname(String name, String surname) {
        return repository.findByFullname(name,surname);
    }

    public void borrowBook(int bookId, int userId){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication(); // !!: en teoria esto coge los datos del usuario loggeado
        User user = repository.findById(userId);
        User loggedUser = repository.findByUsername(auth.getPrincipal().toString()); //??: esto es el username??
        Book book = bookRepository.findById(bookId);
        if(loggedUser.getId()==userId){
            bookService.reduceQuantity(bookId);
            user.addBorrowedBook(book,userId); //??: aquí llamo al método de la entity, no de este service, no?
            Borrowing newBr = new Borrowing(userId,bookId, LocalDate.now(),LocalDate.now().plusDays(15)); //orElse(null)??
            repository.save(user);
            System.out.print("Book borrowed: " + book.getTitle() + " by " + book.getAuthor() + ". RETURN DATE: " + newBr.getReturnDate());
        } else {
            throw new SecurityException("You are not correctly logged. Logging you out ..."); //??: esto no es correcto pero no sé bien qué implica que los dos ids de user no coincidan
            //??: aquí desloggeo al usuario?
        }
    }

    public void addToFavourites(int bookId, int userId){
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
    }




}
