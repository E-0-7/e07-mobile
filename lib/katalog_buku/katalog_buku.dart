import 'package:e07_mobile/katalog_buku/models/userstatus.dart';
import 'package:flutter/material.dart';
import 'package:e07_mobile/katalog_buku/models/buku.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:e07_mobile/authentication/login.dart';
import 'package:e07_mobile/drawer/left_drawer.dart';

import 'package:provider/provider.dart';

class BookCatalog extends StatefulWidget {
  const BookCatalog({Key? key}) : super(key: key);

  @override
  State<BookCatalog> createState() => _BookCatalogState();
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
        title: const Text('Katalog Buku'),
        backgroundColor: const Color(0xFF215082),
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset('asset/images/login_books.png'),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      drawer: const LeftDrawer(),
      backgroundColor: const Color(0xFF0B1F49),
      body: FutureBuilder(
        future: fetchBooks(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(
              child: Text(
                "Tidak ada data produk.",
                style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
              ),
            );
          } else {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Flex-Lib\nKatalog Buku\n\n',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Di Flex-lib, kamu dapat meminjam buku, beli buku, request buku, dan donasi buku lama kamu',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    color: const Color(0xFF163869),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Daftar Buku',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 4,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var book = snapshot.data![index];
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              book.fields.bookAuthor ?? "Tidak Ada Penulis",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              book.fields.tahunPublikasi.toString() == "" ||
                                      book.fields.tahunPublikasi
                                              .toString()
                                              .toLowerCase() ==
                                          "null"
                                  ? "-1"
                                  : book.fields.tahunPublikasi.toString(),
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              book.fields.penerbit ?? "Tidak Ada Penerbit",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(2),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                SliverToBoxAdapter(
                  child: _buildUserSpecificButtons(),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildUserSpecificButtons() {
    final userStatus =
        Provider.of<UserStatusModel>(context, listen: false).userStatus;
    if (userStatus == 'guest') {
      return const SizedBox.shrink(); // No buttons for guests
    } else if (userStatus == 'loggedIn') {
      return _buildLoggedInButtons();
    } else if (userStatus == 'pustakawan') {
      return _buildLibrarianButtons();
    } else {
      return const SizedBox.shrink(); // Default case
    }
  }

  Widget _buildLoggedInButtons() {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(onPressed: () {}, child: const Text('Request Buku')),
        ElevatedButton(onPressed: () {}, child: const Text('Donasi Buku')),
        ElevatedButton(onPressed: () {}, child: const Text('Pinjam Buku')),
        ElevatedButton(onPressed: () {}, child: const Text('Beli Buku')),
      ],
    );
  }

  Widget _buildLibrarianButtons() {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(onPressed: () {}, child: const Text('Request Buku')),
        ElevatedButton(onPressed: () {}, child: const Text('Donasi Buku')),
        ElevatedButton(onPressed: () {}, child: const Text('Pinjam Buku')),
        ElevatedButton(onPressed: () {}, child: const Text('Beli Buku')),
        ElevatedButton(onPressed: () {}, child: const Text('Tambah Buku')),
      ],
    );
  }
}
