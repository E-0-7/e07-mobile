// To parse this JSON data, do
//
//     final donation = donationFromJson(jsonString);

import 'dart:convert';

List<Donation> donationFromJson(String str) => List<Donation>.from(json.decode(str).map((x) => Donation.fromJson(x)));

String donationToJson(List<Donation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Donation {
    String model;
    int pk;
    Fields fields;

    Donation({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Donation.fromJson(Map<String, dynamic> json) => Donation(
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
    String donator;
    DateTime donationDate;
    int donationAmount;
    String title;
    String author;
    int year;
    String imageUrl;
    String status;

    Fields({
        required this.user,
        required this.donator,
        required this.donationDate,
        required this.donationAmount,
        required this.title,
        required this.author,
        required this.year,
        required this.imageUrl,
        required this.status,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        donator: json["donator"],
        donationDate: DateTime.parse(json["donation_date"]),
        donationAmount: json["donation_amount"],
        title: json["title"],
        author: json["author"],
        year: json["year"],
        imageUrl: json["image_url"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "donator": donator,
        "donation_date": "${donationDate.year.toString().padLeft(4, '0')}-${donationDate.month.toString().padLeft(2, '0')}-${donationDate.day.toString().padLeft(2, '0')}",
        "donation_amount": donationAmount,
        "title": title,
        "author": author,
        "year": year,
        "image_url": imageUrl,
        "status": status,
    };
}
