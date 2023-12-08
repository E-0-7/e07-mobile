import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:e07_mobile/request_buku/models/request_buku.dart';
import 'package:e07_mobile/request_buku/screens/main_request_buku.dart';

class RequestBukuForm extends StatefulWidget {
  const RequestBukuForm({super.key});

  @override
  State<RequestBukuForm> createState() => _RequestBukuForm();
}

class _RequestBukuForm extends State<RequestBukuForm> {

  final _formKey = GlobalKey<FormState>();
  String _judul_buku = "";
  String _deskripsi = "";
  String _author_buku = "";
  int _tahun_publikasi = 0;

  
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

  return Scaffold(
    appBar: AppBar(
      title: const Center(
        child: Text(
          'Form Tambah Item',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
    ),
  //TODO: Implement drawer
    body: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child:
        Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Judul Buku",
                labelText: "Judul Buku",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  _judul_buku = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Judul Buku tidak boleh kosong!";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Author Buku",
                labelText: "Author Buku",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  _author_buku = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Engine harus ada!";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Deskripsi",
                labelText: "Deskripsi",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  _deskripsi = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Deskripsi tidak boleh kosong!";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Tahun Publikasi Buku",
                labelText: "Tahun Publikasi Buku",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  _tahun_publikasi = int.parse(value!);
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Tahun Publikasi tidak boleh kosong!";
                }
                if (int.tryParse(value) == null) {
                  return "Tahun Publikasi harus berupa angka!";
                }
                return null;
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {

                    // Kirim ke Django dan tunggu respons
                    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                    final response = await request.post(
                        "http://127.0.0.1:8000/request_buku/create-request-buku/",
                        // "https://thirza-ahmad-tugas.pbp.cs.ui.ac.id/create-flutter/",
                        jsonEncode(<String, String>{
                          'judul_buku': _judul_buku,
                          'author': _author_buku,
                          'deskripsi': _deskripsi,
                          'tahun_publikasi': _tahun_publikasi.toString(),
                          // TODO: Sesuaikan field data sesuai dengan aplikasimu
                        }));
                    if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        content: Text("Produk baru berhasil disimpan!"),
                      ));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainRequestBuku()),
                      );
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        content:
                        Text("Terdapat kesalahan, silakan coba lagi."),
                      ));
                    }
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ]),
      ),
    ),
  );
}
}