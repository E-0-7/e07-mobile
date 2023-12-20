import 'package:flutter/material.dart';

class DonationSearchBar extends StatefulWidget {
  final Function(String) onValueChanged;

  const DonationSearchBar({super.key, required this.onValueChanged});

  @override
  State<DonationSearchBar> createState() => _DonationSearchBarState();
}

class _DonationSearchBarState extends State<DonationSearchBar> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(queryListener);
  }

  @override
  void dispose() {
    searchController.removeListener(queryListener);
    searchController.dispose();
    super.dispose();
  }

  void queryListener() {
    widget.onValueChanged(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: searchController,
      hintText: "Cari buku",
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.search),
      ),
    );
  }
}
