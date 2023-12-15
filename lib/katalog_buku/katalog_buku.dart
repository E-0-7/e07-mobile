import 'dart:convert';
import 'package:e07_mobile/katalog_buku/models/buku.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookCard extends StatelessWidget {
  final Buku book;

  const BookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8), // Ubah margin menjadi 8
      child: Column(
        children: [
          ListTile(
            title: Text(book.fields.bookTitle ?? ''),
            subtitle: Text(book.fields.bookAuthor),
          ),
          Container(
            height: 100, // Ubah tinggi gambar menjadi 100
            child: Image.network(
              book.fields.urlFotoMedium ?? '',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class BookCatalog extends StatefulWidget {
  const BookCatalog({Key? key}) : super(key: key);

  @override
  _BookCatalogState createState() => _BookCatalogState();
}

class _BookCatalogState extends State<BookCatalog> {
  late Future<List<Buku>> books;

  @override
  void initState() {
    super.initState();
    books = fetchBooks();
  }

  Future<List<Buku>> fetchBooks() async {
    final response = await http.get(
      Uri.parse('https://flex-lib.domcloud.dev/json/'),
    );

    if (response.statusCode == 200) {
      return bukuFromJson(response.body);
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Catalog'),
      ),
      body: FutureBuilder<List<Buku>>(
        future: books,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return BookCard(book: snapshot.data![index]);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add logic for the first button
                      },
                      child: Text('Widget 1'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add logic for the second button
                      },
                      child: Text('Widget 2'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add logic for the third button
                      },
                      child: Text('Widget 3'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add logic for the fourth button
                      },
                      child: Text('Widget 4'),
                    ),
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
