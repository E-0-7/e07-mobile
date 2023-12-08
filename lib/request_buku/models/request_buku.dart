// To parse this JSON data, do
//
//     final requestBuku = requestBukuFromJson(jsonString);

import 'dart:convert';

List<RequestBuku> requestBukuFromJson(String str) => List<RequestBuku>.from(json.decode(str).map((x) => RequestBuku.fromJson(x)));

String requestBukuToJson(List<RequestBuku> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RequestBuku {
  String model;
  int pk;
  Fields fields;

  RequestBuku({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory RequestBuku.fromJson(Map<String, dynamic> json) => RequestBuku(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  int user;
  String judulBuku;
  String author;
  int tahunPublikasi;
  String isiBuku;
  DateTime tanggalRequest;

  Fields({
    required this.user,
    required this.judulBuku,
    required this.author,
    required this.tahunPublikasi,
    required this.isiBuku,
    required this.tanggalRequest,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    judulBuku: json["judul_buku"],
    author: json["author"],
    tahunPublikasi: json["tahun_publikasi"],
    isiBuku: json["isi_buku"],
    tanggalRequest: DateTime.parse(json["tanggal_request"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "judul_buku": judulBuku,
    "author": author,
    "tahun_publikasi": tahunPublikasi,
    "isi_buku": isiBuku,
    "tanggal_request": "${tanggalRequest.year.toString().padLeft(4, '0')}-${tanggalRequest.month.toString().padLeft(2, '0')}-${tanggalRequest.day.toString().padLeft(2, '0')}",
  };
}
