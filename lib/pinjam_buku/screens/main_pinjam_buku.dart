import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:e07_mobile/pinjam_buku/models/gabungan_pinjam_buku.dart';
import 'package:e07_mobile/pinjam_buku/screens/katalog_pinjam_buku.dart';

class MainPinjamBuku extends StatefulWidget {
  const MainPinjamBuku({Key? key}) : super(key: key);

  @override
  _MainPinjamBukuState createState() => _MainPinjamBukuState();
}

class _MainPinjamBukuState extends State<MainPinjamBuku> {
  Future<List<GabunganPinjamBuku>> fetchProduct() async {
    var url = Uri.parse('https://flex-lib-e07-tk.pbp.cs.ui.ac.id/pinjam_buku/get_pinjam_data_ajax/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<GabunganPinjamBuku> list_product = [];
    for (var d in data) {
      if (d != null) {
        list_product.add(GabunganPinjamBuku.fromJson(d));
      }
    }
    return list_product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Buku Dipinjam'),
        backgroundColor: const Color(0xFF215082),
        foregroundColor: Colors.white,
        centerTitle: true, // This will center the title
      ),
      backgroundColor: const Color(0xFF0B1F49),
      body: FutureBuilder(
        future: fetchProduct(),
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
                            'Nama Peminjam: ${book.username}',
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