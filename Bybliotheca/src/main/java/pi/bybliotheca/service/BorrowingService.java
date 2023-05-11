package pi.bybliotheca.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pi.bybliotheca.entity.Book;
import pi.bybliotheca.entity.Borrowing;
import pi.bybliotheca.repository.BookRepository;
import pi.bybliotheca.repository.BorrowingRepository;

import java.time.LocalDateTime;

@Service
public class BorrowingService {

    @Autowired
    private BorrowingRepository repository;
    @Autowired
    private BookRepository bookRepository;

    public String renew(int id){
        Borrowing br = repository.findById(id);
        LocalDateTime newReturnDate = br.getReturnDate().plusDays(15);
        return "Done! Your new return date is: " + newReturnDate.toString();
    }

    public Borrowing borrowBook(int bookId){
        Book book = bookRepository.findById(bookId);
        Borrowing newBorrowing = new Borrowing(); //?? : como genero un nuevo id, como cojo el id del usuario logeado? y la returndate se genera automaticamente a partir del get que hice?
        System.out.print("Book borrowed: " + book.getTitle() + " by " + book.getAuthor() + ". RETURN DATE: " + newBorrowing.getReturnDate().toString());
        return newBorrowing;
    }

    // ??: tengo que hacer un método save acaso para invocarlo dentro del borrow? como en el addbook?

}
