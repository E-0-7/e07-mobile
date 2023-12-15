import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Import file buku.dart
import 'package:e07_mobile/katalog_buku/katalog_buku.dart'; // Import file book_catalog.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        // Sesuaikan dengan kebutuhan
        // CookieRequest request = CookieRequest();
        // return request;
      },
      child: MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: BookCatalog(), // Ganti dengan data buku yang sesuai
      ),
    );
  }
}
