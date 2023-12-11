import 'package:flutter/material.dart';
import 'package:e07_mobile/donasi_buku/models/donation.dart';

class DonationCard extends StatelessWidget {
  final Donation donation;
  const DonationCard({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    const String noImage = "https://bookstore.gpo.gov/sites/default/files/styles/product_page_image/public/covers/600x96-official_presidential_portrait_of_barack_obama_20x24.jpg?itok=IompvPfM";
    return Card(
      child: InkWell(
        splashColor: Colors.grey[400],
        onTap: () {},
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                donation.fields.imageUrl != "" && donation.fields.imageUrl != "NULL" ? donation.fields.imageUrl : noImage,
                fit: BoxFit.fill,
              ),
            ),
            ListTile(
              title: Text(donation.fields.title),
              subtitle: Text(donation.fields.status),
            )
          ],
        ),
      ),
    );
  }
}
