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

    public void deleteBook(int id) {
        repository.deleteById(id);
    }

    public Book updateBook(Book book) {
        Book existingBook = repository.findById(book.getId()); //orElse(null)
        existingBook.setTitle(book.getTitle());
        existingBook.setAuthor(book.getAuthor());
        existingBook.setSummary(book.getSummary());
        existingBook.setGenre(book.getGenre());
        existingBook.setNpages(book.getNpages());
        existingBook.setYear(book.getYear());
        System.out.print("Book successfully updated.");
        return repository.save(existingBook);
    }

    public Book getBookById(int id) {
        return repository.findById(id); //orElse(null)
    }

    public Book getBookByTitle(String title) {
        return repository.findByTitle(title);
    }

    /*public List<Book> getBooksByAuthor(String author) {
        List<Book> books = repository.findAll();
        List<Book> booksByAuthor = books.stream()
                .filter(book -> book.getAuthor().equals(author))
                .collect(Collectors.toList());
        return booksByAuthor;
    }*/

    public List<Book> getBooksByAuthor(String author) {
        return repository.findByAuthor(author);
    }

    public List<Book> getBooksByGenre(String genre) {
        return repository.findByGenre(genre);
    }


    /*public List<Book> getBooksByGenre(String genre) {
        List<Book> books = repository.findAll();
        List<Book> booksByGenre = books.stream()
                .filter(book -> book.getGenre().equals(genre))
                .collect(Collectors.toList());
        return booksByGenre;
    }*/

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

    public List<String> getAuthors() {
        List<Book> books = repository.findAll();
        List<String> authors = books.stream()
                .map(Book::getAuthor)
                .collect(Collectors.toList());
        return authors;
    }

    public List<String> getGenres() {
        List<Book> books = repository.findAll();
        List<String> genres = books.stream()
                .map(Book::getGenre)
                .collect(Collectors.toList());
        return genres;
    }
}






