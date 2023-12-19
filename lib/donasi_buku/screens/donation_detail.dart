import 'package:e07_mobile/donasi_buku/models/donation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DonationDetailPage extends StatelessWidget {
  final Donation donation;
  const DonationDetailPage({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    const double imageScale = 4.0;
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Donasi Buku")),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            donation.fields.imageUrl != "" && donation.fields.imageUrl != "NULL"
                ? Image.network(
                    donation.fields.imageUrl,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.height / imageScale,
                    height: MediaQuery.of(context).size.height / imageScale,
                  )
                : Image.asset(
                    "asset/images/no_image_icon.png",
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.height / imageScale,
                    height: MediaQuery.of(context).size.height / imageScale,
                  ),
            const SizedBox(height: 20.0),
            ListTile(
              title: Text(
                "Judul",
                style: GoogleFonts.openSans(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                donation.fields.title,
                style: GoogleFonts.openSans(
                  fontSize: 14.0,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Penulis",
                style: GoogleFonts.openSans(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                donation.fields.author,
                style: GoogleFonts.openSans(
                  fontSize: 14.0,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Tahun Publikasi",
                style: GoogleFonts.openSans(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                donation.fields.year.toString(),
                style: GoogleFonts.openSans(
                  fontSize: 14.0,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Jumlah Donasi",
                style: GoogleFonts.openSans(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                donation.fields.donationAmount.toString(),
                style: GoogleFonts.openSans(
                  fontSize: 14.0,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Tanggal Donasi",
                style: GoogleFonts.openSans(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${donation.fields.donationDate.day.toString().padLeft(2, "0")}/${donation.fields.donationDate.month.toString().padLeft(2, "0")}/${donation.fields.donationDate.year.toString()}",
                style: GoogleFonts.openSans(
                  fontSize: 14.0,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Status",
                style: GoogleFonts.openSans(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                donation.fields.status,
                style: GoogleFonts.openSans(
                  fontSize: 14.0,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      )),
    );
  }
}
