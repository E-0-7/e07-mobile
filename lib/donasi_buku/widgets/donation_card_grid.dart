import 'package:e07_mobile/donasi_buku/models/donation.dart';
import 'package:e07_mobile/donasi_buku/widgets/donation_card.dart';
import 'package:e07_mobile/donasi_buku/widgets/donation_card_admin.dart';
import 'package:e07_mobile/donasi_buku/widgets/donation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class DonationCardGrid extends StatefulWidget {
  final List<Donation> donations;
  final int columns;
  final bool isAdmin;

  const DonationCardGrid(
      {super.key,
      required this.donations,
      required this.columns,
      required this.isAdmin})
      : assert(columns == 2 || columns == 4);

  @override
  State<DonationCardGrid> createState() => _DonationCardGridState();
}

class _DonationCardGridState extends State<DonationCardGrid> {
  late List<Donation> displayedDonations;

  void onDonationStatusChanged(Donation donation, String status) {
    setState(() {
      widget.donations
          .firstWhere((element) => element.pk == donation.pk)
          .fields
          .status = status;
    });
  }

  void onDonationDeleted(Donation donation) {
    setState(() {
      widget.donations.removeWhere((element) => element.pk == donation.pk);
    });
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        displayedDonations = List<Donation>.from(widget.donations);
      });
    } else {
      setState(() {
        displayedDonations = widget.donations
            .where((element) => element.fields.title
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    displayedDonations = List<Donation>.from(widget.donations);
  }

  @override
  Widget build(BuildContext context) {
    final int columns = widget.columns;
    final bool isAdmin = widget.isAdmin;
    int rows = (displayedDonations.length / columns).ceil();

    return Column(children: [
      DonationSearchBar(onValueChanged: search),
      const SizedBox(height: 10),
      rows != 0
          ? LayoutGrid(
              columnSizes:
                  columns == 2 ? [1.fr, 1.fr] : [1.fr, 1.fr, 1.fr, 1.fr],
              rowSizes: List.filled(rows, auto),
              columnGap: 10,
              rowGap: 10,
              children: isAdmin
                  ? displayedDonations
                      .map((donation) => DonationCardAdmin(
                          donation: donation,
                          onDonationStatusChanged: onDonationStatusChanged))
                      .toList()
                  : displayedDonations
                      .map((donation) => DonationCard(
                          donation: donation,
                          onDonationDeleted: onDonationDeleted))
                      .toList(),
            )
          : const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Buku tidak ditemukan",
                style: TextStyle(
                  fontSize: 16,
                ),
              ))
    ]);
  }
}
