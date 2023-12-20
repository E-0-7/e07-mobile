import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:e07_mobile/pinjam_buku/screens/main_pinjam_buku.dart';
import 'package:e07_mobile/pinjam_buku/models/buku.dart';

class FormPinjamBuku extends StatefulWidget {
  final Buku buku;

  const FormPinjamBuku({Key? key, required this.buku}) : super(key: key);

  @override
  State<FormPinjamBuku> createState() => _FormPinjamBukuState();
}

class _FormPinjamBukuState extends State<FormPinjamBuku> {
  final _formKey = GlobalKey<FormState>();
  int _durasi = 0;
  int _nomorTelepon = 0;
  String _alamat = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Form Pinjam Buku'),
        backgroundColor: const Color(0xFF215082),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF0B1F49),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  height: 300,
                  child: Image.network(
                    widget.buku.fields.urlFotoLarge.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.buku.fields.bookTitle.toString(),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  widget.buku.fields.bookAuthor.toString(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  widget.buku.fields.tahunPublikasi.toString(),
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Durasi (Hari)",
                      labelText: "Durasi",
                      errorStyle: TextStyle(
                        color: Colors.red[400],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _durasi = int.tryParse(value) ?? 0;
                        });
                      }
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Durasi tidak boleh kosong!";
                      }
                      if (int.tryParse(value) == null) {
                        return "Durasi harus berupa angka!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "08XXXXXXXXXX",
                      labelText: "Nomor Telepon",
                      errorStyle: TextStyle(
                        color: Colors.red[400],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _nomorTelepon = int.tryParse(value) ?? 0;
                        });
                      }
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Nomor Telepon tidak boleh kosong!";
                      }
                      if (int.tryParse(value) == null) {
                        return "Nomor Telepon harus berupa angka!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Alamat",
                      labelText: "Alamat",
                      errorStyle: TextStyle(
                        color: Colors.red[400],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _alamat = value;
                        });
                      }
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Alamat tidak boleh kosong!";
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
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await request.post(
                              "https://flex-lib.domcloud.dev/pinjam_buku/create_pinjam_buku/",
                              jsonEncode(<String, String>{
                                'buku': widget.buku.pk.toString(),
                                'durasi': _durasi.toString(),
                                'nomor_telepon': _nomorTelepon.toString(),
                                'alamat': _alamat,
                              }));
                          if (response['status'] == 'success') {
                            if (!context.mounted) return;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPinjamBuku()),
                            );
                          } else {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "Terdapat kesalahan, silakan coba lagi."),
                            ));
                          }
                        }
                      },
                      child: const Text(
                        "Pinjam",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
