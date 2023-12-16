import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:e07_mobile/authentication/login.dart';
import 'package:e07_mobile/request_buku/models/request_status_buku.dart';
import 'package:e07_mobile/request_buku/screens/admin_request_buku.dart';
import 'package:e07_mobile/request_buku/screens/detail_request_buku.dart';
import 'package:e07_mobile/drawer/left_drawer.dart';
import 'package:e07_mobile/request_buku/screens/form_request_buku.dart';
import 'package:e07_mobile/request_buku/style/theme.dart';

class MainRequestBuku extends StatefulWidget {
  const MainRequestBuku({Key? key}) : super(key: key);

  @override
  _MainRequestBukuState createState() => _MainRequestBukuState();
}

class _MainRequestBukuState extends State<MainRequestBuku> {
  // Future<List<RequestStatusBuku>> fetchRequestStatusBuku(request) async {
  //   var url = Uri.parse('http://127.0.0.1:8000/request_buku/get_item/');
  //   // var url = "http://127.0.0.1:8000/request_buku/get_item/";
  //   print("Get in");
  //
  //   var response = await http.get(
  //     url,
  //     headers: {"Content-Type": "application/json"},
  //   );
  //
  //   print(response.body);
  //   print("Test");
  //   if (response.statusCode == 200) {
  //     print("Successful response");
  //
  //     try {
  //       var data = jsonDecode(utf8.decode(response.bodyBytes));
  //
  //       if (data is List) {
  //         List<RequestStatusBuku> list_request_status_buku = [];
  //
  //         for (var d in data) {
  //           if (d != null) {
  //             list_request_status_buku.add(RequestStatusBuku.fromJson(d));
  //           }
  //           print("Not null");
  //         }
  //
  //         return list_request_status_buku;
  //       } else {
  //         print("Invalid data format");
  //       }
  //     } catch (e) {
  //       print("Error decoding response: $e");
  //     }
  //   } else {
  //     print("Error response status code: ${response.statusCode}");
  //     print("Response body: ${response.body}");
  //   }
  //   print("Error");
  //   return []; // Return an empty list in case of errors
  // }

  void deleteRequestStatusBuku(request, id) async {
    try {
      // var response = await request.post("https://flex-lib-e07-tk.pbp.cs.ui.ac.id/request_buku/delete_item/$id", {}
        // var response = await request.post("http://127.0.0.1:8000/request_buku/delete_request_buku_flutter/$id", {}
        var response = await request.post("https://flex-lib.domcloud.dev/request_buku/delete_request_buku_flutter/$id", {}
      );
      if (response["status"] == "success") {
        setState(() {});
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<List<RequestStatusBuku>> fetchRequestStatusBuku(request) async {
    List<RequestStatusBuku> list_request_status_buku = [];
    // var response = await request.get("http://127.0.0.1:8000/request_buku/get_item/");
    // var response = await request.get("https://flex-lib-e07-tk.pbp.cs.ui.ac.id/request_buku/get_item/");
    var response = await request.get("https://flex-lib.domcloud.dev/request_buku/get_item/");
    for (var d in response) {
      if (d != null) {
        list_request_status_buku.add(RequestStatusBuku.fromJson(d));
      }
      print("Not null");
    }
    return list_request_status_buku;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset('asset/images/login_books.png'),
                // replace with your image asset
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Text(
            'Request Buku',
            style: ThemeApp.lightTextTheme.displayMedium,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle), // This is the profile icon
              onPressed: () {
                // Add your profile function here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        ),
        drawer: const LeftDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    RequestBukuForm(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = Offset(1.0, 0.0);
                  var end = Offset.zero;
                  var curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Request Buku Image
                      Flexible(
                        flex: 1,
                        // Adjust the flex value to control the image's portion of space
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Image.asset(
                            'asset/images/request_buku.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Text Container
                      Expanded(
                        flex: 2,
                        // Adjust the flex value to control the text's portion of space
                        child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 20),
                            child: Column(
                              children: [
                                Text(
                                  "Request Buku",
                                  style: ThemeApp.lightTextTheme.bodyLarge,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${userData['is_login'] ? 'Selamat Datang ${userData['username']}' : 'Selamat Datang User'}, Silahkan Request Buku. \n Di Flex-lib kamu dapat melakukan Request Buku. Buku yang kamu minta akan diproses dan dipertimbangkan oleh pustakawan untuk disediakan di aplikasi Flex-lib. Kamu dapat melakukan request dengan menekan button lingkaran dibawah",
                                  style: ThemeApp.lightTextTheme.bodyMedium,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),

                ],
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 20, left: 8, right: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue, // This is your background color
                        borderRadius: BorderRadius.circular(
                            10), // This makes the background corners rounded
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: FutureBuilder(
                        future: fetchRequestStatusBuku(request),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: Text(
                                  "Loading...",
                                  style: ThemeApp.lightTextTheme.displayLarge,
                                ),
                              ),
                            );
                          } else {
                            if (!snapshot.hasData) {
                              return Center(
                                child: Text(
                                  "Kamu Belum Membuat Request Buku",
                                  style: ThemeApp.lightTextTheme.displayLarge,
                                ),
                              );
                            } else {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (_, index) => GestureDetector(
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                                DetailRequestBuku(
                                                    statusRequestBuku:
                                                    snapshot.data[index]),
                                            transitionsBuilder: (context, animation,
                                                secondaryAnimation, child) {
                                              var begin = Offset(1.0, 0.0);
                                              var end = Offset.zero;
                                              var curve = Curves.ease;

                                              var tween = Tween(
                                                  begin: begin, end: end)
                                                  .chain(CurveTween(curve: curve));

                                              return SlideTransition(
                                                position: animation.drive(tween),
                                                child: child,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Slidable(
                                          endActionPane: ActionPane(
                                            motion: const DrawerMotion(),
                                            extentRatio: 0.25,
                                            children: [
                                              SlidableAction(
                                                label: 'Delete',
                                                backgroundColor: Colors.red,
                                                icon: Icons.delete,
                                                onPressed: (context) {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext context) =>
                                                          AlertDialog(
                                                            title: const Text(
                                                                "Hapus Request Buku"),
                                                            content: const Text(
                                                                "Apakah kamu yakin ingin menghapus request buku ini?"),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                const Text(
                                                                    "Batal"),
                                                              ),
                                                              TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  deleteRequestStatusBuku(
                                                                      request,
                                                                      snapshot
                                                                          .data![
                                                                      index]
                                                                          .id);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                const Text(
                                                                    "Hapus"),
                                                              ),
                                                            ],
                                                          ));
                                                },
                                              ),
                                              SlidableAction(
                                                  label: 'Edit',
                                                  backgroundColor: Colors.blue,
                                                  icon: Icons.edit,
                                                  onPressed: (context) {
                                                    Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                        pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                            AdminPageRequest(
                                                                requestStatusBuku:
                                                                snapshot.data[
                                                                index]),
                                                        transitionsBuilder:
                                                            (context,
                                                            animation,
                                                            secondaryAnimation,
                                                            child) {
                                                          var begin =
                                                          Offset(1.0, 0.0);
                                                          var end = Offset.zero;
                                                          var curve = Curves.ease;

                                                          var tween = Tween(
                                                              begin: begin,
                                                              end: end)
                                                              .chain(CurveTween(
                                                              curve: curve));

                                                          return SlideTransition(
                                                            position: animation
                                                                .drive(tween),
                                                            child: child,
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  })
                                            ],
                                          ),
                                          child: Container(
                                            child: Card(
                                                elevation: 3,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 20, vertical: 10),
                                                child: Row(children: [
                                                  Column(
                                                    //gambar status dan status
                                                    children: [
                                                      Container(
                                                          width: 100,
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                            color: snapshot
                                                                .data![
                                                            index]
                                                                .status ==
                                                                "DITERIMA"
                                                                ? Color(0x818DFA)
                                                                .withOpacity(1)
                                                                : snapshot
                                                                .data![
                                                            index]
                                                                .status ==
                                                                "DITOLAK"
                                                                ? Color(0xF25C5C)
                                                                .withOpacity(
                                                                1)
                                                                : Color(0xDEC337)
                                                                .withOpacity(
                                                                1),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              Center(
                                                                child: Text(
                                                                  snapshot
                                                                      .data![index]
                                                                      .status,
                                                                  style: ThemeApp
                                                                      .statusTheme
                                                                      .displayMedium,
                                                                ),
                                                              )
                                                            ],
                                                          ))
                                                    ],
                                                  ),
                                                  Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(10),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          children: [
                                                            Row(
                                                              //Nama buku
                                                              children: [
                                                                Text(
                                                                  snapshot.data![index]
                                                                      .judulBuku,
                                                                  style: ThemeApp
                                                                      .lightTextTheme
                                                                      .bodyLarge,
                                                                ),
                                                              ],
                                                            ),
                                                            Row(children: [
                                                              Column(
                                                                //Author Buku
                                                                children: [
                                                                  Text(
                                                                    "Author Buku: ${snapshot.data![index].author}",
                                                                    style: ThemeApp
                                                                        .lightTextTheme
                                                                        .bodyMedium,
                                                                  ),
                                                                ],
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                                  // Tahun Buku (aligned to the right)
                                                                  children: [
                                                                    Text(
                                                                      "Tahun: ${snapshot.data![index].tahunPublikasi.toString()}",
                                                                      style: ThemeApp
                                                                          .lightTextTheme
                                                                          .bodyMedium,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ]),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  snapshot.data![index]
                                                                      .tanggalRequest,
                                                                  style: ThemeApp
                                                                      .lightTextTheme
                                                                      .bodyMedium,
                                                                ),
                                                              ],
                                                              //Tanggal Request
                                                            ),
                                                          ],
                                                        ),
                                                      ))
                                                ])),
                                          ))
                                    //isi status

                                  ));
                            }
                          }
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "asset/images/login_books.png",
                        height: 100,
                        width: 100,
                      ),
                      TextButton(
                        onPressed: () {
                          // Add your function here
                        },
                        child: Text('About Us'),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          // Change this color to change the button text color
                          backgroundColor: Colors.transparent,
                          padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Add your function here
                        },
                        child: Text('Contact Us'),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          // Change this color to change the button text color
                          backgroundColor: Colors.transparent,
                          padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        ),
                      ),
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    "© 2023 Flex-lib e07 - All Rights Reserved",
                    style: ThemeApp.darkTextTheme.bodySmall,
                  ),
                ),
              )
            ])));
  }
}
