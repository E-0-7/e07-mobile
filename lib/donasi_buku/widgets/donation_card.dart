import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:e07_mobile/donasi_buku/screens/donation_detail.dart';
import 'package:e07_mobile/request_buku/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:e07_mobile/donasi_buku/models/donation.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class DonationCard extends StatelessWidget {
  final Donation donation;
  final Function(Donation) onDonationDeleted;
  const DonationCard(
      {super.key, required this.donation, required this.onDonationDeleted});

  @override
  Widget build(BuildContext context) {
    const double imageScale = 4;
    final request = context.watch<CookieRequest>();

    return Card(
      color: Colors.blue,
      elevation: 6.0,
      child: InkWell(
        splashColor: Colors.blue[300],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DonationDetailPage(donation: donation)),
          );
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: donation.fields.imageUrl != "" &&
                                donation.fields.imageUrl != "NULL"
                            ? Image.network(
                                donation.fields.imageUrl,
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.height /
                                    imageScale,
                                height: MediaQuery.of(context).size.height /
                                    imageScale,
                              )
                            : Image.asset(
                                "asset/images/no_image_icon.png",
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.height /
                                    imageScale,
                                height: MediaQuery.of(context).size.height /
                                    imageScale,
                              )),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            ListTile(
              title: Text(
                "Judul",
                style: GoogleFonts.openSans(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              subtitle: Text(
                donation.fields.title,
                style:
                    GoogleFonts.openSans(fontSize: 12.0, color: Colors.white),
              ),
            ),
            ListTile(
              title: Text(
                "Penulis",
                style: ThemeApp.darkTextTheme.bodyLarge,
              ),
              subtitle: Text(donation.fields.author,
                  style: ThemeApp.darkTextTheme.bodySmall),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  donation.fields.status == "PENDING"
                      ? Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              final response = await request.postJson(
                                  "https://flex-lib.domcloud.dev/donasi_buku/delete-flutter/",
                                  //"http://localhost:8000/donasi_buku/delete-flutter/",
                                  jsonEncode(<String, String>{
                                    'id': donation.pk.toString()
                                  }));
                              if (response['status'] == 'success') {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Donasi berhasil dihapus!"),
                                ));
                                onDonationDeleted(donation);
                              } else {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Terdapat kesalahan, silakan coba lagi.")));
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.0),
                              child: Text("Cancel Donation", textAlign: TextAlign.center),
                          ),
                        ))
                      : const SizedBox(height: 0.0),
                  const SizedBox(height: 12.0),
                  Center(
                    child: Text(
                      donation.fields.status,
                      style: GoogleFonts.openSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
