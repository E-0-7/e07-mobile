import 'package:e07_mobile/donasi_buku/models/donation.dart';
import 'package:e07_mobile/donasi_buku/widgets/donation_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  late Future<List<Donation>> futureDonations;

  Future<List<Donation>> fetchDonations() async {
    final response =
        await http.get(Uri.parse("http://127.0.0.1:8000/donasi_buku/json/"));
    if (response.statusCode == 200) {
      return donationFromJson(response.body);
    } else {
      throw Exception("Failed to load donations");
    }
  }

  @override
  void initState() {
    super.initState();
    futureDonations = fetchDonations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donasi Buku"),
      ),
      drawer: const Placeholder(),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Donasikan bukumu"),
              const SizedBox(height: 10.0),
              SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Icon(Icons.search),
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(5, (index) {
                    final String item = "item $index";
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                        });
                      },
                    );
                  });
                },
              ),
              const SizedBox(height: 10.0),
              FutureBuilder<List<Donation>>(
                  future: futureDonations,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // return GridView.count(
                      //   primary: false,
                      //   scrollDirection: Axis.vertical,
                      //   shrinkWrap: true,
                      //   padding: const EdgeInsets.all(20),
                      //   crossAxisSpacing: 10,
                      //   mainAxisSpacing: 10,
                      //   crossAxisCount:
                      //       orientation == Orientation.portrait ? 2 : 4,
                      //   childAspectRatio: 2 / 3,
                      //   children: List<DonationCard>.generate(7, (index) {
                      //     return const DonationCard(donation: null);
                      //   }),
                      // );
                      List<Donation> donations = snapshot.data!;
                      if (donations.isEmpty) {
                        return const Text("Anda belum ada donasi buku");
                      } else {
                        return GridView.builder(
                            primary: false,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(20),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  orientation == Orientation.portrait ? 2 : 4,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 3 / 4,
                            ),
                            itemCount: donations.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DonationCard(donation: donations[index]);
                            });
                      }
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const CircularProgressIndicator();
                  }),
            ],
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "Buat Donasi",
        child: const Icon(Icons.add),
      ),
    );
  }
}
