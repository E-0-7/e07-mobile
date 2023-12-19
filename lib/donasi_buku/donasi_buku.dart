import 'dart:convert';

import 'package:e07_mobile/authentication/login.dart';
import 'package:e07_mobile/donasi_buku/models/donation.dart';
import 'package:e07_mobile/donasi_buku/screens/donation_form.dart';
import 'package:e07_mobile/donasi_buku/widgets/donation_card_grid.dart';
import 'package:flutter/material.dart';
import 'package:e07_mobile/drawer/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  Future<List<Donation>> fetchDonations(CookieRequest request) async {
    final response = await request.postJson(
        //"http://localhost:8000/donasi_buku/get-donations/",
        "https://flex-lib.domcloud.dev/donasi_buku/get-donations/",
        jsonEncode(<String, String>{
          'place': 'holder',
        }));
    List<Donation> donations = [];
    for (var d in response) {
      if (d != null) {
        donations.add(Donation.fromJson(d));
      }
    }
    return donations;
  }


  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset('asset/images/login_books.png'),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: const Text("Donasi Buku"),
      ),
      drawer: const LeftDrawer(),
      body: Align(
          alignment: Alignment.topCenter,
          child: OrientationBuilder(
            builder: (context, orientation) {
              return SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Donasikan bukumu",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(height: 12.0),
                          SearchAnchor(
                            builder: (BuildContext context,
                                SearchController controller) {
                              return SearchBar(
                                controller: controller,
                                padding:
                                    const MaterialStatePropertyAll<EdgeInsets>(
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
                            suggestionsBuilder: (BuildContext context,
                                SearchController controller) {
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
                              future: fetchDonations(request),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<Donation> donations = snapshot.data!;
                                  if (donations.isEmpty) {
                                    return const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Text(
                                          "Anda belum ada donasi buku",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ));
                                  } else {
                                    return DonationCardGrid(
                                      donations: donations,
                                      columns:
                                          orientation == Orientation.portrait
                                              ? 2
                                              : 4,
                                      isAdmin:
                                          userData["username"] == "pustakawan",
                                    );
                                  }
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return const CircularProgressIndicator();
                              }),
                        ],
                      )));
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DonationForm()));
        },
        tooltip: "Buat Donasi",
        child: const Icon(Icons.add),
      ),
    );
  }
}
