import 'dart:convert';

List<Buku> bukuFromJson(String str) => List<Buku>.from(json.decode(str).map((x) => Buku.fromJson(x)));

String bukuToJson(List<Buku> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Buku {
  Model model;
  int pk;
  Fields fields;

  Buku({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Buku.fromJson(Map<String, dynamic> json) => Buku(
    model: modelValues.map[json["model"]]!,
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": modelValues.reverse[model],
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  String isbn;
  String? bookTitle;
  String bookAuthor;
  int tahunPublikasi;
  String penerbit;
  String? urlFotoKecil;
  String? urlFotoMedium;
  String? urlFotoLarge;
  int bookPrice;

  Fields({
    required this.isbn,
    required this.bookTitle,
    required this.bookAuthor,
    required this.tahunPublikasi,
    required this.penerbit,
    required this.urlFotoKecil,
    required this.urlFotoMedium,
    required this.urlFotoLarge,
    required this.bookPrice,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    isbn: json["isbn"],
    bookTitle: json["book_title"],
    bookAuthor: json["book_author"],
    tahunPublikasi: json["tahun_publikasi"],
    penerbit: json["penerbit"],
    urlFotoKecil: json["url_foto_kecil"],
    urlFotoMedium: json["url_foto_medium"],
    urlFotoLarge: json["url_foto_large"],
    bookPrice: json["book_price"],
  );

  Map<String, dynamic> toJson() => {
    "isbn": isbn,
    "book_title": bookTitle,
    "book_author": bookAuthor,
    "tahun_publikasi": tahunPublikasi,
    "penerbit": penerbit,
    "url_foto_kecil": urlFotoKecil,
    "url_foto_medium": urlFotoMedium,
    "url_foto_large": urlFotoLarge,
    "book_price": bookPrice,
  };
}

enum Model {
  KATALOG_BUKU_BUKU
}

final modelValues = EnumValues({
  "katalog_buku.buku": Model.KATALOG_BUKU_BUKU
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}