import 'package:flutter/material.dart';
import 'package:e07_mobile/katalog_buku/models/buku.dart';
import 'package:e07_mobile/beli_buku/screens/BeliBukuForm.dart';

class CatalogCardBuy extends StatelessWidget {
  final Buku book;

  const CatalogCardBuy({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF163869),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: Image.network(
                book.fields.urlFotoLarge ??
                    "http://images.amazon.com/images/P/1879384493.01.LZZZZZZZ.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              book.fields.bookTitle ?? "Tidak Ada Judul",
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 5),
            Text(
              book.fields.bookAuthor,
              style: const TextStyle(
                  fontSize: 16, fontStyle: FontStyle.italic, color: Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 5),
            Text(
              book.fields.tahunPublikasi.toString(),
              style: const TextStyle(fontSize: 14, color: Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 5),
            Text(
              book.fields.penerbit,
              style: const TextStyle(fontSize: 14, color: Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FormBeliBuku(buku: book)),
                    );
                  },
                  child: Text(
                    "Buy Rp${book.fields.bookPrice}", // Include the book price in the text
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
