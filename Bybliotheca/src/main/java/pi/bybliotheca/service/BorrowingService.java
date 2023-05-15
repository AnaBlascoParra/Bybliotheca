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
        Book book = bookRepository.findById(bookId);
        bookService.reduceQuantity(bookId);
        Borrowing newBr = new Borrowing(userId,bookId, LocalDate.now(),LocalDate.now().plusDays(15));
        System.out.print("Book borrowed: " + book.getTitle() + " by " + book.getAuthor() + ". RETURN DATE: " + newBr.getReturnDate());
    }

    public void returnBook(int borrowingId){
        Borrowing br = repository.findById(borrowingId);
        Book book = bookRepository.findById(br.getBookId());
        bookService.increaseQuantity(book.getId());
        br.setReturnDate(LocalDate.now());
        System.out.print("Book returned");
    }

}





