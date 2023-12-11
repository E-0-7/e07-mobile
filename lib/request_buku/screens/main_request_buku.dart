import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:e07_mobile/authentication/login.dart';
import 'package:e07_mobile/request_buku/models/request_status_buku.dart';
import 'package:e07_mobile/request_buku/screens/form_request_buku.dart';
import 'package:e07_mobile/request_buku/screens/detail_request_buku.dart';
import 'package:e07_mobile/request_buku/style/theme.dart';

class MainRequestBuku extends StatefulWidget {
  const MainRequestBuku({Key? key}) : super(key: key);

  @override
  _MainRequestBukuState createState() => _MainRequestBukuState();
}

class _MainRequestBukuState extends State<MainRequestBuku> {
  Future<List<RequestStatusBuku>> fetchRequestStatusBuku() async {
    var url = Uri.parse('http://127.0.0.1:8000/request_buku/get_item/');
    print("Get in");

    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);
    print("Test");
    if (response.statusCode == 200) {
      print("Successful response");

      try {
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        if (data is List) {
          List<RequestStatusBuku> list_request_status_buku = [];

          for (var d in data) {
            if (d != null) {
              list_request_status_buku.add(RequestStatusBuku.fromJson(d));
            }
            print("Not null");
          }

          return list_request_status_buku;
        } else {
          print("Invalid data format");
        }
      } catch (e) {
        print("Error decoding response: $e");
      }
    } else {
      print("Error response status code: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
    print("Error");
    return []; // Return an empty list in case of errors
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu), // This is the hamburger menu icon
            onPressed: () {
              // Add your hamburger menu function here
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

        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RequestBukuForm()),
            );
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child:
          Column(
              children: [
                const SizedBox(height: 20),
            Column(

              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Request Buku Image
                    Flexible(
                      flex: 1, // Adjust the flex value to control the image's portion of space
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Image.network(
                          "https://img.freepik.com/free-vector/hand-holding-book_25030-38690.jpg?w=740&t=st=1701933689~exp=1701934289~hmac=3ed81a2e63f18e0de28f53c1dd3810e7a62ec379991169af46c51c3684e1f2df",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Text Container
                    Expanded(
                      flex: 2, // Adjust the flex value to control the text's portion of space
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
                              "Selamat Datang User, Silahkan Request Buku. \n Di Flex-lib kamu dapat melakukan Request Buku. Buku yang kamu minta akan diproses dan dipertimbangkan oleh pustakawan untuk disediakan di aplikasi Flex-lib. Kamu dapat melakukan request dengan menekan button lingkaran dibawah",
                              style: ThemeApp.lightTextTheme.bodyMedium,
                            ),
                          ],
                        )

                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(

                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(10.0),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Add your search function here
                      },
                    ),
                  ],
                )

              ],
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 20, left: 8, right: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue, // This is your background color
                    borderRadius: BorderRadius.circular(10), // This makes the background corners rounded
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FutureBuilder(
                      future: fetchRequestStatusBuku(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if(snapshot.data == null) {
                          return Container(
                            child: Center(
                              child: Text("Loading..."),
                            ),
                          );
                        }
                        else {
                          if(!snapshot.hasData) {
                            return Center(
                              child: Text("Kamu Belum Membuat Request Buku", style: ThemeApp.lightTextTheme.displayLarge,),
                            );
                          }
                          else {
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, index) => GestureDetector(
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation, secondaryAnimation) => DetailRequestBuku(statusRequestBuku: snapshot.data[index]),
                                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                            var begin = Offset(1.0, 0.0);
                                            var end = Offset.zero;
                                            var curve = Curves.ease;

                                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                            return SlideTransition(
                                              position: animation.drive(tween),
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(

                                      child:
                                      Card(
                                          elevation: 3,
                                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: Row(children: [
                                            Column(
                                              //gambar status dan status
                                              children: [
                                                Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: snapshot.data![index].status == "DITERIMA" ?
                                                      Color(0x818DFA).withOpacity(1) :
                                                      snapshot.data![index].status == "DITOLAK" ?
                                                      Color(0xF25C5C).withOpacity(1) :
                                                      Color(0xDEC337).withOpacity(1),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            snapshot.data![index].status,
                                                            style: ThemeApp.statusTheme.displayMedium,
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
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Row(
                                                        //Nama buku
                                                        children: [
                                                          Text(snapshot.data![index].judulBuku, style: ThemeApp.lightTextTheme.bodyLarge,),
                                                        ],
                                                      ),
                                                      Row(
                                                          children: [
                                                            Column(
                                                              //Author Buku
                                                              children: [
                                                                Text(snapshot.data![index].author, style: ThemeApp.lightTextTheme.bodyMedium,),
                                                              ],
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                // Tahun Buku (aligned to the right)
                                                                children: [
                                                                  Text(snapshot.data![index].tahunPublikasi.toString(), style: ThemeApp.lightTextTheme.bodyMedium,),
                                                                ],
                                                              ),
                                                            ),
                                                          ]),
                                                      Row(
                                                        children: [
                                                          Text(snapshot.data![index].tanggalRequest, style: ThemeApp.lightTextTheme.bodyMedium,),
                                                        ],
                                                        //Tanggal Request
                                                      ),
                                                    ],

                                                  ),
                                                )
                                            )
                                          ]
                                          )
                                      ),
                                    )
                                )
                              //isi status


                            );
                          }
                        }
                      }

                  ),
                )

              ],
            )


          ])
        )
       );
  }
}
