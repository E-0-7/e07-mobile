import 'package:flutter/material.dart';
import 'package:e07_mobile/request_buku/models/request_status_buku.dart';
import 'package:e07_mobile/request_buku/style/theme.dart';

class DetailRequestBuku extends StatelessWidget {
  final RequestStatusBuku statusRequestBuku;

  const DetailRequestBuku({super.key, required this.statusRequestBuku});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Request Buku")),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Judul Buku : ${statusRequestBuku.judulBuku}",
                      style: ThemeApp.lightTextTheme.titleLarge),
                  Text(
                    "Author : ${statusRequestBuku.author}",
                    style: ThemeApp.lightTextTheme.displaySmall,
                  ),
                  Text(
                    "Tahun Publikasi : ${statusRequestBuku.tahunPublikasi}",
                    style: ThemeApp.lightTextTheme.displaySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Deskripsi : ",
                  style: ThemeApp.lightTextTheme.bodyMedium,
                ),
                Text(
                  statusRequestBuku.isiBuku,
                  style: ThemeApp.lightTextTheme.bodyMedium,
                ),
                const SizedBox(height: 30.0),
                Text(
                  "Status : ${statusRequestBuku.status}",
                  style: ThemeApp.lightTextTheme.bodyLarge,
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: const Text('Kembali'),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
