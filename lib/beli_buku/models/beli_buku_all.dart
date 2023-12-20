import 'dart:convert';

enum PaymentMethod { debitCreditCard, eWallet, qris }

List<BeliBukuAll> beliBukuAllFromJson(String str) => List<BeliBukuAll>.from(
    json.decode(str).map((x) => BeliBukuAll.fromJson(x)));

String beliBukuAllToJson(List<BeliBukuAll> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BeliBukuAll {
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
  int jumlah;
  int nomorTelepon;
  String alamat;
  PaymentMethod paymentMethod;

  BeliBukuAll({
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
    required this.jumlah,
    required this.nomorTelepon,
    required this.alamat,
    required this.paymentMethod,
  });

  factory BeliBukuAll.fromJson(Map<String, dynamic> json) => BeliBukuAll(
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
        jumlah: json["jumlah"],
        nomorTelepon: json["nomor_telepon"],
        alamat: json["alamat"],
        paymentMethod: PaymentMethod.debitCreditCard,
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
        "jumlah": jumlah,
        "nomor_telepon": nomorTelepon,
        "alamat": alamat,
        "paymentMethod": paymentMethod.index,
      };
}
