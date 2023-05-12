package pi.bybliotheca.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import pi.bybliotheca.entity.Book;
import pi.bybliotheca.entity.Borrowing;
import pi.bybliotheca.repository.BookRepository;
import pi.bybliotheca.repository.BorrowingRepository;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Service
public class BorrowingService {

    @Autowired
    private BorrowingRepository repository;

    public void renew(int borrowingId){
        Borrowing br = repository.findById(borrowingId);
        LocalDate newReturnDate = br.getReturnDate().plusDays(15);
        System.out.print("Success! Your new return date is: " + newReturnDate);
    }



}
