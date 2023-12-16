import 'dart:convert';

import 'package:e07_mobile/donasi_buku/donasi_buku.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class DonationForm extends StatefulWidget {
  const DonationForm({super.key});

  @override
  State<DonationForm> createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _author = "";
  int _year = 0;
  String _imageUrl = "";
  int _amount = 0;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Donasi Buku Baru"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20.0),
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
                  onChanged: (value) {
                    setState(() {
                      _title = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Judul buku tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Penulis Buku",
                    labelText: "Penulis Buku",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _author = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Penulis buku tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: "Tahun Terbit Buku",
                    labelText: "Tahun Terbit Buku",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _year = int.parse(value);
                    });
                  },
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Tolong masukkan tahun";
                    }
                    if (int.tryParse(value) == null) {
                      return "Tolong masukkan angka valid";
                    }
                    if (int.parse(value) <= 0) {
                      return "Tolong masukkan angka lebih besar dari 0";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL Foto Buku",
                    labelText: "URL Foto Buku",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _imageUrl = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "bruh";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: "Jumlah Donasi Buku",
                    labelText: "Jumlah Donasi Buku",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _amount = int.parse(value);
                    });
                  },
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Tolong masukkan tahun";
                    }
                    if (int.tryParse(value) == null) {
                      return "Tolong masukkan angka valid";
                    }
                    if (int.parse(value) <= 0) {
                      return "Tolong masukkan angka lebih besar dari 0";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 12.0),
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
                        final response = await request.postJson(
                            "http://localhost:8000/donasi_buku/donate-flutter/",
                            jsonEncode(<String, String>{
                              'title': _title,
                              'author': _author,
                              'year': _year.toString(),
                              'image_url': _imageUrl,
                              'donation_amount': _amount.toString()
                            }));
                        if (response['status'] == 'success') {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Donasi berhasil!"),
                          ));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DonationPage()));
                          _formKey.currentState!.reset();
                        } else {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Terdapat kesalahan, silakan coba lagi.")));
                        }
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
