import 'package:flutter/material.dart';
import 'package:book_management_app/models/book.dart';

class BookAddPage extends StatefulWidget {
  const BookAddPage({super.key});

  @override
  State<BookAddPage> createState() => _BookAddPageState();
}

class _BookAddPageState extends State<BookAddPage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String author = '';
  String description = '';
  String notes = '';
  String genre = '';
  bool isRead = false;

  final List<String> genres = [
    'Roman',
    'Bilim Kurgu',
    'Fantastik',
    'Klasikler',
    'Tarih',
    'Biyografi',
    'Kişisel Gelişim',
    'Psikoloji',
    'Felsefe',
    'Şiir',
    'Bilim',
    'Dini',
    'Edebiyat',
    'Polisiye / Gerilim',
    'Aksiyon / Macera',
    'Mizah',
    'Sanat',
    'Gezi',
    'Eğitim',
    'Çocuk Kitapları',
    'Genç Yetişkin',
    'Ekonomi / İş Dünyası',
    'Sağlık / Beslenme',
    'Bilgisayar / Teknoloji',
    'Aşk / Romantik',
    'Mitoloji',
    'Oyun / Eğlence',
    'Korku',
    'Sosyoloji'
  ]; // Tür seçenekleri

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitap Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Kitap İsmi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kitap ismi zorunludur';
                  }
                  return null;
                },
                onSaved: (value) => title = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Yazar'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Yazar ismi zorunludur';
                  }
                  return null;
                },
                onSaved: (value) => author = value!,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Kitap Türü'),
                items: genres.map((genre) {
                  return DropdownMenuItem(
                    value: genre,
                    child: Text(genre),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    genre = value!;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Açıklama'),
                onSaved: (value) => description = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Kişisel Notlar'),
                onSaved: (value) => notes = value ?? '',
              ),
              Row(
                children: [
                  Checkbox(
                    value: isRead,
                    onChanged: (value) {
                      setState(() {
                        isRead = value ?? false;
                      });
                    },
                  ),
                  const Text('Okundu'),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newBook = Book(
                      title: title,
                      author: author,
                      description: description,
                      notes: notes,
                      genre: genre,
                      isRead: isRead,
                    );

                    Navigator.pop(context, newBook);
                  }
                },
                child: const Text('Kitabı Ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
