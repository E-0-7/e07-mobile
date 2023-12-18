import 'package:e07_mobile/donasi_buku/donasi_buku.dart';
import 'package:flutter/material.dart';
import 'package:e07_mobile/katalog_buku/katalog_buku.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:e07_mobile/katalog_buku/models/userstatus.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserStatusModel(),
      child: MyApp(),
      )
  );    
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
          return request;
      },
      child: MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: BookCatalog()
      ),
    );
  }
}
