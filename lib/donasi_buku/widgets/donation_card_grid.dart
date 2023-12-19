import 'package:e07_mobile/donasi_buku/models/donation.dart';
import 'package:e07_mobile/donasi_buku/widgets/donation_card.dart';
import 'package:e07_mobile/donasi_buku/widgets/donation_card_admin.dart';
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

  @override
  Widget build(BuildContext context) {
    final List<Donation> donations = widget.donations;
    final int columns = widget.columns;
    final bool isAdmin = widget.isAdmin;
    int rows = (donations.length / columns).ceil();

    return LayoutGrid(
      columnSizes: columns == 2 ? [1.fr, 1.fr] : [1.fr, 1.fr, 1.fr, 1.fr],
      rowSizes: List.filled(rows, auto),
      columnGap: 10,
      rowGap: 10,
      children: isAdmin
          ? donations
              .map((donation) => DonationCardAdmin(
                  donation: donation,
                  onDonationStatusChanged: onDonationStatusChanged))
              .toList()
          : donations
              .map((donation) => DonationCard(
                  donation: donation, onDonationDeleted: onDonationDeleted))
              .toList(),
    );
  }
}
