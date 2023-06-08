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
import java.util.List;
import java.util.stream.Collectors;

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

    public void borrowBook(String bookTitle, int userId){
        Book book = bookRepository.findByTitle(bookTitle);
        bookService.reduceQuantity(bookTitle);
        Borrowing newBr = new Borrowing(userId,bookTitle, LocalDate.now(),LocalDate.now().plusDays(15));
    }

    public void returnBook(int borrowingId){
        Borrowing br = repository.findById(borrowingId);
        Book book = bookRepository.findByTitle(br.getBookTitle());
        bookService.increaseQuantity(book.getTitle());
        br.setReturnDate(LocalDate.now());
        System.out.print("Book returned");
    }

    public List<Book> getBorrowedBooks(int userId){
        List<Borrowing> allBorrowings = repository.findAll().stream().collect(Collectors.toList());
        List<Book> borrowedBooks = allBorrowings.stream()
                                        .filter(x->x.getUserId()==userId)
                                        .map(x->bookRepository.findByTitle(x.getBookTitle()))
                                        .collect(Collectors.toList());
        return borrowedBooks;
    }

}





