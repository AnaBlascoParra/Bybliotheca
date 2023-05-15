package pi.bybliotheca.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import pi.bybliotheca.entity.Book;
import pi.bybliotheca.entity.BookFav;
import pi.bybliotheca.entity.User;
import pi.bybliotheca.repository.BookFavRepository;
import pi.bybliotheca.repository.BookRepository;
import pi.bybliotheca.repository.UserRepository;

import java.util.List;

@Service
public class BookFavService {

    @Autowired
    private BookFavRepository repository;

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserService userService;

    public BookFav addBookToFavs(int bookId){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loggedUser = userRepository.findByUsername(auth.getPrincipal().toString());
        Book book = bookRepository.findById(bookId);
        BookFav newBf = new BookFav(bookId, loggedUser.getId());
        System.out.print("Book successfully added to favourites: " + book.getTitle() + " by " + book.getAuthor());
        return newBf;
    }

    public void removeBookFromFavs(int bfId){
        BookFav bf = repository.findById(bfId);
        List<Book> favedBooks = userService.getFavedBooks(userRepository.findById(bf.getUserId()));
        favedBooks.remove(bf.getBookId());
        User user = userRepository.findById(bf.getUserId());
        userRepository.save(user);
        System.out.print("Book successfully removed from 'Favourites'.");
    }

}
