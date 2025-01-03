import 'package:flutter/material.dart';
import 'book.dart';

class BookHelper with ChangeNotifier {
  List<Book> books = [];
  List<Book> filteredBooks = [];

  BookHelper() {
    _initializeBooks();
  }

  void _initializeBooks() {
    books = [
      Book(
        title: "1984",
        author: "George Orwell",
        description: "A dystopian novel about totalitarianism.",
        notes: "Okundu",
        genre: "Bilim Kurgu",
        isRead: true,
      ),
      Book(
        title: "Animal Farm",
        author: "George Orwell",
        description:
            "An allegorical novella reflecting on totalitarian regimes.",
        notes: "Anlamlı bir hikaye",
        genre: "Bilim Kurgu",
        isRead: true,
      ),
      Book(
        title: "Sapiens",
        author: "Yuval Noah Harari",
        description: "A brief history of humankind.",
        notes: "Başlangıç",
        genre: "Tarih",
        isRead: false,
      ),
      Book(
        title: "Homo Deus",
        author: "Yuval Noah Harari",
        description: "A look at the future of humanity.",
        notes: "Gelecek üzerine düşünceler",
        genre: "Tarih",
        isRead: false,
      ),
      Book(
        title: "The Great Gatsby",
        author: "F. Scott Fitzgerald",
        description: "A story of lost dreams and moral decay in the 1920s.",
        notes: "Okundu",
        genre: "Klasikler",
        isRead: true,
      ),
      Book(
        title: "Gödel, Escher, Bach",
        author: "Douglas Hofstadter",
        description: "An exploration of consciousness and recursive structures.",
        notes: "İnceleme devam ediyor",
        genre: "Bilim",
        isRead: false,
      ),
      Book(
        title: "Sherlock Holmes: A Study in Scarlet",
        author: "Arthur Conan Doyle",
        description: "The first story of the famous detective Sherlock Holmes.",
        notes: "Macera dolu",
        genre: "Polisiye / Gerilim",
        isRead: true,
      ),
      Book(
        title: "Nutuk",
        author: "Mustafa Kemal Atatürk",
        description: "A historic speech by the founder of modern Turkey.",
        notes: "Tarihsel açıdan önemli",
        genre: "Tarih",
        isRead: true,
      ),
      Book(
        title: "Dune",
        author: "Frank Herbert",
        description: "An epic science fiction saga set in a desert planet.",
        notes: "Henüz okunmadı",
        genre: "Bilim Kurgu",
        isRead: false,
      ),
      Book(
        title: "Fahrenheit 451",
        author: "Ray Bradbury",
        description: "A novel about a future society where books are banned.",
        notes: "Toplumsal mesaj içeriyor",
        genre: "Bilim Kurgu",
        isRead: true,
      ),
      Book(
        title: "Pride and Prejudice",
        author: "Jane Austen",
        description: "A romantic novel on British upper class society.",
        notes: "Okundu",
        genre: "Roman",
        isRead: true,
      ),
      Book(
        title: "Kürk Mantolu Madonna",
        author: "Sabahattin Ali",
        description: "A story of love and loneliness in pre-WWII Turkey.",
        notes: "Duygusal",
        genre: "Roman",
        isRead: true,
      ),
    ];
    filteredBooks = List.from(books);
    notifyListeners();
  }
  void toggleReadStatus(Book book) {
    final index = books.indexOf(book);
    if (index != -1) {
      books[index].isRead = !books[index].isRead; // Durumu değiştir
      notifyListeners(); // Değişiklikleri bildir
    }
  }

  void addBook(Book book) {
    books.add(book);
    filteredBooks = List.from(books);
    notifyListeners();
  }

  void sortBooksByName(bool ascending) {
    filteredBooks.sort((a, b) =>
        ascending ? a.title.compareTo(b.title) : b.title.compareTo(a.title));
    notifyListeners();
  }

  void filterBooksBySearchQuery(String query) {
    if (query.length < 3) {
      filteredBooks = List.from(books);
    } else {
      filteredBooks = books.where((book) {
        final lowerCaseQuery = query.toLowerCase();
        return book.title.toLowerCase().contains(lowerCaseQuery) ||
            book.author.toLowerCase().contains(lowerCaseQuery) ||
            book.description.toLowerCase().contains(lowerCaseQuery);
      }).toList();
    }
    notifyListeners();
  }

  void filterBooksByReadStatus(bool isRead) {
    filteredBooks = books.where((book) => book.isRead == isRead).toList();
    notifyListeners();
  }

  void resetFilters() {
    filteredBooks = List.from(books);
    notifyListeners();
  }

   void deleteBook(BuildContext context, Book book) {
    books.remove(book);
    filteredBooks.remove(book);
    notifyListeners();
  /*  } 

  void deleteBookWithUndo(BuildContext context, Book book) {
  books.remove(book);
  filteredBooks.remove(book);
  notifyListeners();  */

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${book.title} silindi'),
      action: SnackBarAction(
        label: 'Geri Al',
        onPressed: () {
          books.add(book);
          filteredBooks.add(book);
          notifyListeners();
        },
      ),
    ),
  );
}
}
