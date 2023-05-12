package pi.bybliotheca.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import pi.bybliotheca.entity.Book;
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

    public String deleteUser(int id) {
        repository.deleteById(id);
        return "User removed" + id;
    }

    public User updateUser(User user) { //no he puesto el dni porque me parecería un poco raro poder cambiar eso
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

    public User getUserByFullname(String name, String surname) {
        return repository.findByFullname(name,surname);
    }

    public void borrowBook(int bookId, int userId){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication(); // !!: en teoria esto coge los datos del usuario loggeado
        User user = repository.findById(userId);
        User loggedUser = repository.findByUsername(auth.getPrincipal().toString()); //??: esto es el username??
        Book book = bookRepository.findById(bookId);
         //?? : FALTA por rellenar el constructor . como genero un nuevo id, como cojo el id del usuario logeado? y la returndate se genera automaticamente a partir del get que hice?
        if(user.getId()== loggedUser.getId()){
            
            user.getBorrowed().add(book);
            Borrowing newBr = new Borrowing(userId,bookId, LocalDate.now(),LocalDate.now().plusDays(15)); //orElse(null)??
            System.out.print("Book borrowed: " + book.getTitle() + " by " + book.getAuthor() + ". RETURN DATE: " + newBr.getReturnDate());
        } else {
        }
    }

    // ??: tengo que hacer un método save acaso para invocarlo dentro del borrow? como en el addbook?

}
