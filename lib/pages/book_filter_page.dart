import 'package:flutter/material.dart';

class BookFilterPage extends StatefulWidget {
  final List<String> genres;
  final Function(List<String> selectedGenres, bool? isRead) onApplyFilters;

  const BookFilterPage({
    super.key,
    required this.genres,
    required this.onApplyFilters,
  });

  @override
  _BookFilterPageState createState() => _BookFilterPageState();
}

class _BookFilterPageState extends State<BookFilterPage> {
  List<String> selectedGenres = [];
  bool? isRead;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtrele'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const Text(
                  'Tür Seçiniz:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ...widget.genres.map(
                  (genre) => CheckboxListTile(
                    title: Text(genre),
                    value: selectedGenres.contains(genre),
                    onChanged: (value) {
                      setState(() {
                        value == true
                            ? selectedGenres.add(genre)
                            : selectedGenres.remove(genre);
                      });
                    },
                  ),
                ),
                const Divider(),
                const Text(
                  'Okuma Durumu:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                RadioListTile<bool?>(
                  title: const Text('Okunan Kitaplar'),
                  value: true,
                  groupValue: isRead,
                  onChanged: (value) {
                    setState(() {
                      isRead = value;
                    });
                  },
                ),
                RadioListTile<bool?>(
                  title: const Text('Okunmayan Kitaplar'),
                  value: false,
                  groupValue: isRead,
                  onChanged: (value) {
                    setState(() {
                      isRead = value;
                    });
                  },
                ),
                RadioListTile<bool?>(
                  title: const Text('Hepsi'),
                  value: null,
                  groupValue: isRead,
                  onChanged: (value) {
                    setState(() {
                      isRead = value;
                    });
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onApplyFilters(selectedGenres, isRead);
              Navigator.pop(context);
            },
            child: const Text('Filtreleri Uygula'),
          ),
        ],
      ),
    );
  }
}
