import 'dart:convert';

List<GabunganPinjamBuku> gabunganPinjamBukuFromJson(String str) =>
    List<GabunganPinjamBuku>.from(
        json.decode(str).map((x) => GabunganPinjamBuku.fromJson(x)));

String gabunganPinjamBukuToJson(List<GabunganPinjamBuku> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GabunganPinjamBuku {
  int id;
  String isbn;
  String bookTitle;
  String bookAuthor;
  int tahunPublikasi;
  String penerbit;
  String urlFotoKecil;
  String urlFotoMedium;
  String urlFotoLarge;
  int bookPrice;
  String username;
  int durasi;
  int nomorTelepon;
  String alamat;

  GabunganPinjamBuku({
    required this.id,
    required this.isbn,
    required this.bookTitle,
    required this.bookAuthor,
    required this.tahunPublikasi,
    required this.penerbit,
    required this.urlFotoKecil,
    required this.urlFotoMedium,
    required this.urlFotoLarge,
    required this.bookPrice,
    required this.username,
    required this.durasi,
    required this.nomorTelepon,
    required this.alamat,
  });

  factory GabunganPinjamBuku.fromJson(Map<String, dynamic> json) =>
      GabunganPinjamBuku(
        id: json["id"],
        isbn: json["isbn"],
        bookTitle: json["book_title"],
        bookAuthor: json["book_author"],
        tahunPublikasi: json["tahun_publikasi"],
        penerbit: json["penerbit"],
        urlFotoKecil: json["url_foto_kecil"],
        urlFotoMedium: json["url_foto_medium"],
        urlFotoLarge: json["url_foto_large"],
        bookPrice: json["book_price"],
        username: json["username"],
        durasi: json["durasi"],
        nomorTelepon: json["nomor_telepon"],
        alamat: json["alamat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isbn": isbn,
        "book_title": bookTitle,
        "book_author": bookAuthor,
        "tahun_publikasi": tahunPublikasi,
        "penerbit": penerbit,
        "url_foto_kecil": urlFotoKecil,
        "url_foto_medium": urlFotoMedium,
        "url_foto_large": urlFotoLarge,
        "book_price": bookPrice,
        "username": username,
        "durasi": durasi,
        "nomor_telepon": nomorTelepon,
        "alamat": alamat,
      };
}
