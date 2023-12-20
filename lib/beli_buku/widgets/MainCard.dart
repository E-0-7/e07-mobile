import 'package:flutter/material.dart';
import 'package:e07_mobile/beli_buku/models/BeliBukuAll.dart';

class MainCard extends StatelessWidget {
  final BeliBukuAll book;

  const MainCard({Key? key, required this.book}) : super(key: key);

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
                book.urlFotoLarge,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              book.bookTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 5),
            Text(
              book.bookAuthor,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color:Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 5),
            Text(
              book.tahunPublikasi.toString(),
              style: const TextStyle(fontSize: 14, color:Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 5),
            Text(
              'Nama Pembeli: ${book.username}',
              style: const TextStyle(fontSize: 13, color:Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 5),
            Text(
              'Jumlah Buku: ${book.jumlah.toString()} Buah',
              style: const TextStyle(fontSize: 13, color:Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 5),
            Text(
              'Nomor Telepon: ${book.nomorTelepon.toString()}',
              style: const TextStyle(fontSize: 13, color:Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 5),
            Text(
              'Alamat: ${book.alamat}',
              style: const TextStyle(fontSize: 13, color:Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}