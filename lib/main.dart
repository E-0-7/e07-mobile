import 'package:flutter/material.dart';
import 'package:e07_mobile/katalog_buku/user_manager.dart';
import 'package:e07_mobile/katalog_buku/katalog_buku.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // MyApp remains unchanged...

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: UserManager().getUserStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            // Setup MaterialApp...
            home: BookCatalog(userStatus: snapshot.data ?? 'guest'),
          );
        } else {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }
}
