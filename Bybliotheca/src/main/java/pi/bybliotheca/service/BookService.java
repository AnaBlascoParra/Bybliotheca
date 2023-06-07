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
        return repository.findAll().stream().collect(Collectors.toList());
    }

    public Book saveBook(Book book) {
        return repository.save(book);
    }

    public void deleteBook(Book book) {
        repository.deleteById(book.getId());
    }

    public void deleteByTitle(String title){
        repository.deleteByTitle(title);
    }

    public Book updateBook(Book book) {
        Book existingBook = repository.findByTitle(book.getTitle());
        existingBook.setTitle(book.getTitle());
        existingBook.setAuthor(book.getAuthor());
        existingBook.setSummary(book.getSummary());
        existingBook.setGenre(book.getGenre());
        existingBook.setNpages(book.getNpages());
        existingBook.setYear(book.getYear());
        existingBook.setImg(book.getImg());
        return repository.save(existingBook);
    }

    public Book getBookById(int id) {
        return repository.findById(id);
    }

    public Book getBookByTitle(String title) {
        return repository.findByTitle(title);
    }

    public List<Book> getBooksByAuthor(String author) {
        return repository.findByAuthor(author);
    }

    public List<Book> getBooksByGenre(String genre) {
        return repository.findByGenre(genre);
    }

    public void reduceQuantity(int id){
        Book book = repository.findById(id);
        if(book.getQty() == 0){
            throw new ArithmeticException("No existences left.");
        } else {
            book.setQty(book.getQty()-1);
            repository.save(book);
        }
    }

    public void increaseQuantity(int id){
        Book book = repository.findById(id);
        book.setQty(book.getQty()+1);
        repository.save(book);
    }

}






