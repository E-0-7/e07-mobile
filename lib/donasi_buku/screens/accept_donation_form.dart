import 'dart:convert';

import 'package:e07_mobile/donasi_buku/donasi_buku.dart';
import 'package:e07_mobile/donasi_buku/models/donation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AcceptDonationForm extends StatefulWidget {
  final Donation donation;
  final Function(Donation) onDonationStatusChanged;
  const AcceptDonationForm(
      {super.key,
      required this.donation,
      required this.onDonationStatusChanged});

  @override
  State<AcceptDonationForm> createState() => _AcceptDonationFormState();
}

class _AcceptDonationFormState extends State<AcceptDonationForm> {
  final _formKey = GlobalKey<FormState>();
  String _isbn = "";
  String _publisher = "";
  int _price = 0;

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
                    hintText: "ISBN",
                    labelText: "ISBN",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _isbn = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value == "") {
                      return "ISBN tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Penerbit Buku",
                    labelText: "Penerbit Buku",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _publisher = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Penerbit buku tidak boleh kosong!";
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
                    hintText: "Harga Buku",
                    labelText: "Harga Buku",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _price = int.parse(value);
                    });
                  },
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Tolong masukkan harga";
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
                        String noImageUrl =
                            "https://cdn.discordapp.com/attachments/1120757548992172154/1186629629725913138/no_image_icon.png?ex=6593f1f6&is=65817cf6&hm=bda5b71edee807b71c947064f0d4f53121dd08942c9f0210ee53427360b1c025&";
                        String imageUrl =
                            widget.donation.fields.imageUrl != "" &&
                                    widget.donation.fields.imageUrl != "NULL"
                                ? widget.donation.fields.imageUrl
                                : noImageUrl;
                        final response = await request.postJson(
                            //"http://localhost:8000/donasi_buku/donate-flutter/",
                            "https://flex-lib.domcloud.dev/donasi_buku/donate-flutter/",
                            jsonEncode(<String, String>{
                              'isbn': _isbn,
                              'book_title': widget.donation.fields.title,
                              'book_author': widget.donation.fields.author,
                              'tahun_publikasi':
                                  widget.donation.fields.year.toString(),
                              'penerbit': _publisher,
                              'url_foto_kecil': imageUrl,
                              'url_foto_medium': imageUrl,
                              'url_foto_large': imageUrl,
                              'book_price': _price.toString(),
                            }));
                        if (response['status'] == 'success') {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Buku berhasil diterima!"),
                          ));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DonationPage()));
                          _formKey.currentState!.reset();
                          widget.onDonationStatusChanged(widget.donation);
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
