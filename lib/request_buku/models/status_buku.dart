// To parse this JSON data, do
//
//     final statusBuku = statusBukuFromJson(jsonString);

import 'dart:convert';

List<StatusBuku> statusBukuFromJson(String str) =>
    List<StatusBuku>.from(json.decode(str).map((x) => StatusBuku.fromJson(x)));

String statusBukuToJson(List<StatusBuku> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatusBuku {
  String model;
  int pk;
  Fields fields;

  StatusBuku({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory StatusBuku.fromJson(Map<String, dynamic> json) => StatusBuku(
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
  int buku;
  String status;

  Fields({
    required this.buku,
    required this.status,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        buku: json["buku"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "buku": buku,
        "status": status,
      };
}
