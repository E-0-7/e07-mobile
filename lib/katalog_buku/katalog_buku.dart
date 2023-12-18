import 'package:flutter/material.dart';
import 'package:e07_mobile/katalog_buku/models/buku.dart';
import 'package:http/http.dart' as http;
import 'package:e07_mobile/katalog_buku/user_manager.dart';  // Asumsi Anda telah membuat file ini

class BookCatalog extends StatefulWidget {
  final String userStatus;

  const BookCatalog({Key? key, this.userStatus = 'guest'}) : super(key: key);

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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Buku>>(
              future: books,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: BookCard(book: snapshot.data![index]),
                      );
                    },
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
          ),
          _buildUserSpecificButtons(),
        ],
      ),
    );
  }

  Widget _buildUserSpecificButtons() {
    switch (widget.userStatus) {
      case 'pustakawan':
        return _buildLibrarianButtons();
      case 'loggedIn':
        return _buildLoggedInButtons();
      default:
        return SizedBox.shrink(); // Tidak menampilkan tombol untuk 'guest'
    }
  }

  Widget _buildLibrarianButtons() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(5, (index) => ElevatedButton(
          onPressed: () {
            // Aksi untuk tombol pustakawan
          },
          child: Text('Librarian Btn ${index+1}'),
        )),
      ),
    );
  }

  Widget _buildLoggedInButtons() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(4, (index) => ElevatedButton(
          onPressed: () {
            // Aksi untuk tombol pengguna yang sudah login
          },
          child: Text('User Btn ${index+1}'),
        )),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Buku book;

  const BookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ukuran dasar untuk kartu
    double cardWidth = MediaQuery.of(context).size.width * 0.5; // Lebar kartu 50% dari layar
    double imageHeight = cardWidth; // Tinggi gambar sama dengan lebar untuk membuatnya kotak

    return Card(
      margin: EdgeInsets.all(8.0), // Margin untuk kartu
      child: SizedBox(
        width: cardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Gambar
            Container(
              width: cardWidth,
              height: imageHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(book.fields.urlFotoMedium ?? ''),
                  fit: BoxFit.cover, // Cover untuk memenuhi seluruh kontainer
                ),
              ),
            ),
            // Judul Buku
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                book.fields.bookTitle ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            // Penulis
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Penulis: ${book.fields.bookAuthor}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
