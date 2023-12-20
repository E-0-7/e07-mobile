import 'dart:convert';
import 'package:e07_mobile/beli_buku/screens/BeliBukuMainPage.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:e07_mobile/katalog_buku/models/buku.dart';

class FormBeliBuku extends StatefulWidget {
  final Buku buku;

  const FormBeliBuku({Key? key, required this.buku}) : super(key: key);

  @override
  _FormBeliBukuState createState() => _FormBeliBukuState();
}

class _FormBeliBukuState extends State<FormBeliBuku> {
  final _formKey = GlobalKey<FormState>();
  int _jumlah = 1;
  int _nomorTelepon = 0;
  String _alamat = "";
  String _selectedPaymentMethod = 'Debit Card/Credit Card';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    final List<String> paymentMethods = [
      'Debit Card/Credit Card',
      'E-Wallet',
      'QRIS',
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Form Beli Buku'),
        backgroundColor: const Color(0xFF215082),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF0B1F49),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                Container(
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
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  widget.buku.fields.bookAuthor.toString(),
                  style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.white),
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
                      hintText: "Jumlah Buku Dibeli",
                      labelText: "Jumlah",
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
                          _jumlah = int.tryParse(value) ?? 0;
                        });
                      }
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Jumlah Buku tidak boleh kosong!";
                      }
                      if (int.tryParse(value) == null) {
                        return "Jumlah Buku harus berupa angka!";
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Metode Pembayaran',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    value: _selectedPaymentMethod,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedPaymentMethod = newValue;
                        });
                      }
                    },
                    items: paymentMethods.map((String method) {
                      return DropdownMenuItem<String>(
                        value: method,
                        child: Text(method),
                      );
                    }).toList(),
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
                          try {
                            final response = await request.postJson(
                              "https://flex-lib.domcloud.dev/beli_buku/create_beli_buku/",
                              jsonEncode(<String, String>{
                                'buku': widget.buku.pk.toString(),
                                'jumlah': _jumlah.toString(),
                                'nomor_telepon': _nomorTelepon.toString(),
                                'alamat': _alamat,
                                'metode_pembayaran': _selectedPaymentMethod,
                              }),
                            );

                            final Map<String, dynamic> responseBody = json.decode(response.body);

                            if (responseBody['status'] == 'success') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const BeliBukuMainPage()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Terdapat kesalahan, silakan coba lagi."),
                                ),
                              );
                            }
                          } catch (error) {
                            print("Error: $error");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Terdapat kesalahan pada server."),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text(
                        "BUY",
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
