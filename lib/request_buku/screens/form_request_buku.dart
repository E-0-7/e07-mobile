import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:e07_mobile/request_buku/screens/main_request_buku.dart';

class RequestBukuForm extends StatefulWidget {
  const RequestBukuForm({super.key});

  @override
  State<RequestBukuForm> createState() => _RequestBukuForm();
}

class _RequestBukuForm extends State<RequestBukuForm> {
  final _formKey = GlobalKey<FormState>();
  String _judulBuku = "";
  String _deskripsi = "";
  String _authorBuku = "";
  int _tahunPublikasi = 0;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Request Buku',
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
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
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
                    _judulBuku = value!;
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
                    _authorBuku = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    _authorBuku = "Tidak Diketahui";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 10,
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
                    _deskripsi = "Tidak Diketahui";
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
                    _tahunPublikasi = int.parse(value!);
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    _tahunPublikasi = -1;
                  }
                  if (int.tryParse(value!) == null) {
                    _tahunPublikasi = -1;
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
                          // "http://127.0.0.1:8000/request_buku/create-request-buku/",
                          //   "https://flex-lib-e07-tk.pbp.cs.ui.ac.id/request_buku/create-request-buku/",
                          "https://flex-lib.domcloud.dev/request_buku/create-request-buku/",
                          jsonEncode(<String, String>{
                            'judul_buku': _judulBuku,
                            'author': _authorBuku,
                            'deskripsi': _deskripsi,
                            'tahun_publikasi': _tahunPublikasi.toString(),
                            // TODO: Sesuaikan field data sesuai dengan aplikasimu
                          }));
                      if (response['status'] == 'success') {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Produk baru berhasil disimpan!"),
                        ));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainRequestBuku()),
                        );
                      } else {
                        if (!context.mounted) return;
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
