// To parse this JSON data, do
//
//     final requestStatusBuku = requestStatusBukuFromJson(jsonString);

import 'dart:convert';

List<RequestStatusBuku> requestStatusBukuFromJson(String str) => List<RequestStatusBuku>.from(json.decode(str).map((x) => RequestStatusBuku.fromJson(x)));

String requestStatusBukuToJson(List<RequestStatusBuku> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RequestStatusBuku {
  int id;
  int user;
  String judulBuku;
  String author;
  int tahunPublikasi;
  String isiBuku;
  String status;
  String tanggalRequest;

  RequestStatusBuku({
    required this.id,
    required this.user,
    required this.judulBuku,
    required this.author,
    required this.tahunPublikasi,
    required this.isiBuku,
    required this.status,
    required this.tanggalRequest,
  });

  factory RequestStatusBuku.fromJson(Map<String, dynamic> json) => RequestStatusBuku(
    id: json["id"],
    user: json["user"],
    judulBuku: json["judul_buku"],
    author: json["author"],
    tahunPublikasi: json["tahun_publikasi"],
    isiBuku: json["isi_buku"],
    status: json["status"],
    tanggalRequest: json["tanggal_request"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "judul_buku": judulBuku,
    "author": author,
    "tahun_publikasi": tahunPublikasi,
    "isi_buku": isiBuku,
    "status": status,
    "tanggal_request": tanggalRequest,
  };
}
