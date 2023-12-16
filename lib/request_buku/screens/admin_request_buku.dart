import 'package:flutter/material.dart';
import 'package:e07_mobile/request_buku/models/request_status_buku.dart';
import 'package:e07_mobile/request_buku/models/status_buku.dart';
import 'package:e07_mobile/request_buku/style/theme.dart';
import 'package:e07_mobile/request_buku/screens/main_request_buku.dart';
import 'package:provider/provider.dart';
import 'package:e07_mobile/authentication/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AdminPageRequest extends StatefulWidget {
  final RequestStatusBuku requestStatusBuku;

  const AdminPageRequest({Key? key, required this.requestStatusBuku}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPageRequest> {
  final _formKey = GlobalKey<FormState>();
  String status = "";
  final List<String> statusBuku =
  [
    "PENDING",
    "DITERIMA",
    "DITOLAK"
  ];
  String dropdownValue = "";

  _AdminPageState() {
    dropdownValue = statusBuku.first;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Admin Page for Request Buku',
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
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text("Info Request"),
                  Text("Judul Buku : " + widget.requestStatusBuku.judulBuku),
                  Text("Deskripsi : " + widget.requestStatusBuku.isiBuku),
                  Text("Author Buku : " + widget.requestStatusBuku.author),
                  Text("Tahun Publikasi : " + widget.requestStatusBuku.tahunPublikasi.toString()),
                  Text("Tanggal Request : " + widget.requestStatusBuku.tanggalRequest),
                  Row(
                      children: [
                        Text("Status Buku : "),
                        DropdownButton<String>(
                          value: dropdownValue,
                          style: ThemeApp.lightTextTheme.bodyMedium,
                          items: statusBuku.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: ThemeApp.lightTextTheme.bodyMedium),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // final response = await request.post("http://127.0.0.1:8000/request_buku/change_status/",
                                  // final response = await request.post("https://flex-lib-e07-tk.pbp.cs.ui.ac.id/request_buku/change_status/",
                                  final response = await request.post("https://flex-lib.domcloud.dev/request_buku/change_status/",
                                      jsonEncode(<String, String>{
                                        "id_buku" : widget.requestStatusBuku.id.toString(),
                                        "status" : dropdownValue,
                                      })
                                  );
                                  if(response['status'] == 'success'){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainRequestBuku()));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(response['message']),
                                          backgroundColor: Colors.red,
                                        )
                                    );
                                  }
                                }
                              }, child: const Text("Submit"),
                            )
                        ),
                      ]
                  )
                ],
              )
          ),
        )
    );

  }}