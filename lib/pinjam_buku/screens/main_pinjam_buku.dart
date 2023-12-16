import 'package:e07_mobile/authentication/login.dart';
import 'package:e07_mobile/drawer/left_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:e07_mobile/pinjam_buku/models/gabungan_pinjam_buku.dart';
import 'package:e07_mobile/pinjam_buku/screens/katalog_pinjam_buku.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class MainPinjamBuku extends StatefulWidget {
  const MainPinjamBuku({Key? key}) : super(key: key);

  @override
  _MainPinjamBukuState createState() => _MainPinjamBukuState();
}

class _MainPinjamBukuState extends State<MainPinjamBuku> {
  Future<List<GabunganPinjamBuku>> fetchProduct(request) async {
    List<GabunganPinjamBuku> list_pinjam_buku = [];
    var response = await request.get("https://flex-lib.domcloud.dev/pinjam_buku/get_pinjam_data_ajax/");
    for (var d in response) {
      if (d != null) {
        list_pinjam_buku.add(GabunganPinjamBuku.fromJson(d));
      }
      print("Not null");
    }
    return list_pinjam_buku;
  }
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Buku Dipinjam'),
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
      ),
      drawer: const LeftDrawer(),
      backgroundColor: const Color(0xFF0B1F49),
      body: FutureBuilder(
        future: fetchProduct(request),
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
                            text: 'Flex-Lib\nList Pinjam Buku\n\n',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Berikut adalah daftar buku yang telah kamu pinjam dari Flex-Lib. Pastikan untuk mengembalikan buku tepat waktu dan menikmati pembacaanmu!',
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
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    color: const Color(0xFF163869),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Daftar Buku Dipinjam',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                          ),
                          onPressed: () async {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const KatalogPinjamBuku()),
                            );
                          },
                          child: const Text(
                            "Pinjam Buku",
                            style: TextStyle(color: Colors.white),
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
                            'Nama Peminjam: ${userData['username']}',
                            style: const TextStyle(fontSize: 13, color:Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            ),
                          const SizedBox(height: 5),
                          Text(
                            'Durasi (Hari): ${book.durasi.toString()} Hari',
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
                },
                staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}