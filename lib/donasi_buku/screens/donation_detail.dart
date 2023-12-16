import 'package:e07_mobile/donasi_buku/models/donation.dart';
import 'package:flutter/material.dart';

class DonationDetailPage extends StatelessWidget {
  final Donation donation;
  const DonationDetailPage({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    const String noImage =
        "https://bookstore.gpo.gov/sites/default/files/styles/product_page_image/public/covers/600x96-official_presidential_portrait_of_barack_obama_20x24.jpg?itok=IompvPfM";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Request Buku")
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              donation.fields.imageUrl != "" && donation.fields.imageUrl != "NULL" ? donation.fields.imageUrl : noImage
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Judul Buku : ${donation.fields.title}"),
                  Text("Author : ${donation.fields.author}"),
                  Text("Tahun Publikasi : ${donation.fields.year}"),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Jumlah donasi: ${donation.fields.donationAmount}"),
                Text("Tanggal donasi: ${donation.fields.donationDate.day.toString().padLeft(2, "0")}/${donation.fields.donationDate.month.toString().padLeft(2, "0")}/${donation.fields.donationDate.year.toString()}"),
                const SizedBox(height: 30.0),
                Text("Status: ${donation.fields.status}"),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: const Text('Kembali'),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
