import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_management_app/models/book_helper.dart';
import 'package:book_management_app/models/book.dart';
import 'package:book_management_app/pages/book_add_page.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  bool _isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    final bookHelper = Provider.of<BookHelper>(context);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (query) => bookHelper.filterBooksBySearchQuery(query),
          decoration: const InputDecoration(
            hintText: 'Kitap ara...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white54),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'A-Z') {
                bookHelper.sortBooksByName(true);
              } else if (value == 'Z-A') {
                bookHelper.sortBooksByName(false);
              } else if (value == 'Read') {
                bookHelper.filterBooksByReadStatus(true);
              } else if (value == 'Unread') {
                bookHelper.filterBooksByReadStatus(false);
              } else if (value == 'Reset') {
                bookHelper.resetFilters();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: 'A-Z', child: Text('Kitap İsmi (A-Z)')),
              const PopupMenuItem(
                  value: 'Z-A', child: Text('Kitap İsmi (Z-A)')),
              const PopupMenuItem(
                  value: 'Read', child: Text('Okunan Kitaplar')),
              const PopupMenuItem(
                  value: 'Unread', child: Text('Okunmayan Kitaplar')),
              const PopupMenuItem(
                  value: 'Reset', child: Text('Filtreleri Temizle')),
            ],
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            if (scrollNotification.scrollDelta! > 0) {
              setState(() {
                _isFabVisible = false;
              });
            } else if (scrollNotification.scrollDelta! < 0) {
              setState(() {
                _isFabVisible = true;
              });
            }
          }
          return true;
        },
        child: ListView.builder(
          itemCount: bookHelper.filteredBooks.length,
          itemBuilder: (context, index) {
            final book = bookHelper.filteredBooks[index];
            return Dismissible(
              key: ValueKey(book.title),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              confirmDismiss: (direction) async {
                final shouldDelete =
                    await _showDeleteConfirmationDialog(context, book);
                return shouldDelete ?? false;
              },
              onDismissed: (direction) {
                bookHelper.deleteBook(context, book);
              },
              child: Card(
                elevation: 8,
                margin:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: ListTile(
                  title: Text(
                    book.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book.author),
                      Text(
                        book.genre,
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  trailing: IconButton(
                      icon: Icon(
                        book.isRead
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: book.isRead ? Colors.green : Colors.grey,
                      ),
                      onPressed: () {
                        bookHelper.toggleReadStatus(book);
                      }),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: _isFabVisible
          ? FloatingActionButton(
              onPressed: () async {
                final newBook = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookAddPage()),
                );

                if (newBook != null && newBook is Book) {
                  bookHelper.addBook(newBook);
                }
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Future<bool?> _showDeleteConfirmationDialog(
      BuildContext context, Book book) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kitabı Sil'),
          content:
              Text('${book.title} adlı kitabı silmek istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Hayır'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Evet'),
            ),
          ],
        );
      },
    );
  }
}
