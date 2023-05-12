package pi.bybliotheca.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pi.bybliotheca.entity.Book;
import pi.bybliotheca.repository.BookRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class BookService {

    @Autowired
    private BookRepository repository;

    public List<Book> getBooks(){
        return repository.findAll();
    }

    public Book saveBook(Book book) {
        return repository.save(book);
    }

    public String deleteBook(int id) {
        repository.deleteById(id);
        return "Book successfully deleted.";
    }

    public Book updateBook(Book book) {
        Book existingBook = repository.findById(book.getId()); //orElse(null)
        existingBook.setTitle(book.getTitle());
        existingBook.setAuthor(book.getAuthor());
        existingBook.setGenre(book.getGenre());
        existingBook.setNpages(book.getNpages());
        existingBook.setYear(book.getYear());
        return repository.save(existingBook);
    }

    public Book getBookById(int id) {
        return repository.findById(id); //orElse(null)
    }

    public Book getBookByTitle(String title) {
        return repository.findByTitle(title);
    }
    public List<Book> getBooksByAuthor(String author) {
        List<Book> books = repository.findAll();
        List<Book> booksByAuthor = books.stream()
                .filter(book -> book.getAuthor().equals(author))
                .collect(Collectors.toList());
        return booksByAuthor;
    }

    public List<Book> getBooksByGenre(String genre) {
        List<Book> books = repository.findAll();
        List<Book> booksByGenre = books.stream()
                .filter(book -> book.getGenre().equals(genre))
                .collect(Collectors.toList());
        return booksByGenre;
    }

    public void reduceQuantity(int id){
        Book book = repository.findById(id);
        if(book.getQty() == 0){
            System.out.print("No existences left.");
        } else {
            book.setQty(book.getQty()-1);
            repository.save(book);
        }
    }





}
