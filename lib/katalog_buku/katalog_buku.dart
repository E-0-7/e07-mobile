import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e07_mobile/katalog_buku/models/buku.dart';

class BookCatalog extends StatefulWidget {
  final List<Buku> bookList;

  const BookCatalog({Key? key, required this.bookList}) : super(key: key);

  @override
  _BookCatalogState createState() => _BookCatalogState();
}

class _BookCatalogState extends State<BookCatalog> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Katalog Buku'),
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: widget.bookList.map((buku) {
              return Container(
                margin: EdgeInsets.all(8.0),
                child: Card(
                  // Customize card UI based on your needs
                  child: Column(
                    children: [
                      Image.network(buku.fields.urlFotoMedium ?? ''),
                      Text(buku.fields.bookTitle ?? ''),
                      Text(buku.fields.bookAuthor),
                    ],
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 300.0,
              enableInfiniteScroll: false,
              viewportFraction: 0.8,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.bookList.map((buku) {
              int index = widget.bookList.indexOf(buku);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
                ),
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement your logic for the first button
                },
                child: Text('Button 1'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement your logic for the second button
                },
                child: Text('Button 2'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement your logic for the third button
                },
                child: Text('Button 3'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement your logic for the fourth button
                },
                child: Text('Button 4'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<List<Buku>> fetchData() async {
    final response = await http.get(Uri.parse('URL_API_ANDA')); // Ganti dengan URL API Anda
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return bukuFromJson(json.encode(data));
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<List<Buku>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BookCatalog(
              bookList: snapshot.data!,
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}