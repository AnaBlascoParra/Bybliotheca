package pi.bybliotheca.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import pi.bybliotheca.entity.Book;
import pi.bybliotheca.entity.Borrowing;
import pi.bybliotheca.entity.User;
import pi.bybliotheca.repository.BookRepository;
import pi.bybliotheca.repository.BorrowingRepository;
import pi.bybliotheca.repository.UserRepository;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Service
public class BorrowingService {

    @Autowired
    private BorrowingRepository repository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private BookService bookService;



    public void renew(int borrowingId){
        Borrowing br = repository.findById(borrowingId);
        LocalDate newReturnDate = br.getReturnDate().plusDays(15);
        System.out.print("Success! Your new return date is: " + newReturnDate);
    }

    public void borrowBook(int bookId, int userId){
        //Authentication auth = SecurityContextHolder.getContext().getAuthentication(); // !!: en teoria esto coge los datos del usuario loggeado
        //User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString()); //??: esto es el username??
        Book book = bookRepository.findById(bookId);
        //if(loggedUser.getId()==userId || loggedUser.getRole().equals("ADMIN")){
            bookService.reduceQuantity(bookId);
            Borrowing newBr = new Borrowing(userId,bookId, LocalDate.now(),LocalDate.now().plusDays(15));
            System.out.print("Book borrowed: " + book.getTitle() + " by " + book.getAuthor() + ". RETURN DATE: " + newBr.getReturnDate());
        //} else {
           // throw new SecurityException("Invalid operation");
        //}
    }

    public void returnBook(int borrowingId){ //TO-DO
        //Authentication auth = SecurityContextHolder.getContext().getAuthentication(); // !!: en teoria esto coge los datos del usuario loggeado
        //User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString()); //??: esto es el username??
        Borrowing br = repository.findById(borrowingId);
        Book book = bookRepository.findById(br.getBookId());
        //if(loggedUser.getId()==userId){
            bookService.increaseQuantity(book.getId());
            br.setReturnDate(LocalDate.now());
            System.out.print("Book returned");
        //} else {
           // throw new SecurityException("You are not correctly logged. Logging you out ..."); //??: esto no es correcto pero no sé bien qué implica que los dos ids de user no coincidan
            //??: aquí desloggeo al usuario?
        }
    }





