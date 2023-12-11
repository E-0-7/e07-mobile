import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BookCatalog(
        bookList: bukuFromJson(yourJsonString), // Replace with your actual JSON data
      ),
    );
  }
}
