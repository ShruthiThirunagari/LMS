package com.cis.batch33.library.service;

import com.cis.batch33.library.model.Book;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;

@Service
public class BookService {

    private Map<Long, Book> bookMap = new HashMap<>();

    // Create a book
    public Book createBook(Book book) {
        Long bookId = generateBookId();
        book.setBookId(bookId);
        bookMap.put(bookId, book);
        return book;
    }

    // Get a book by ID
    public Book getBook(Long bookId) {
        return bookMap.get(bookId);
    }

    // Update a book
    public Book updateBook(Long bookId, Book updatedBook) {
        if (bookMap.containsKey(bookId)) {
            updatedBook.setBookId(bookId);
            bookMap.put(bookId, updatedBook);
            return updatedBook;
        }
        return null; // Book not found
    }

    // Delete a book
    public void deleteBook(Long bookId) {
        bookMap.remove(bookId);
    }

    // Get all books
    public List<Book> getAllBooks() {
        return bookMap.values().stream().collect(Collectors.toList());
    }

    // Generate a random book ID
    private Long generateBookId() {
        return new Random().nextLong();
    }
}

