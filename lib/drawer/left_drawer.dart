import 'package:e07_mobile/donasi_buku/donasi_buku.dart';
import 'package:flutter/material.dart';
import 'package:e07_mobile/request_buku/style/theme.dart';
import 'package:e07_mobile/request_buku/screens/main_request_buku.dart';
import 'package:e07_mobile/pinjam_buku/screens/katalog_pinjam_buku.dart';
import 'package:provider/provider.dart';
import 'package:e07_mobile/authentication/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: Column(
            children: [
              Text(
                "Flex-Lib",
                textAlign: TextAlign.left,
                style: ThemeApp.lightTextTheme.bodyLarge,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Text(
                "Berpindah Halaman",
                textAlign: TextAlign.left,
                style: ThemeApp.lightTextTheme.bodyMedium,
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Katalog Buku'),
          onTap: () {
            // Ke Katalog Buku
          },
        ),
        ListTile(
          leading: const Icon(Icons.book_online),
          title: const Text('Request Buku'),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainRequestBuku(),
                ));
          },
        ),
        ListTile(
          leading: const Icon(Icons.volunteer_activism),
          title: const Text('Donasi Buku'),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DonationPage(),
                ));
          },
        ),
        ListTile(
          leading: const Icon(Icons.shopping_cart),
          title: const Text('Beli Buku'),
          onTap: () {
            // Ke Keranjang
          },
        ),
        ListTile(
          leading: const Icon(Icons.handshake),
          title: const Text('Pinjam Buku'),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const KatalogPinjamBuku(),
                ));
          },
        ),
        ListTile(
          leading: const Icon(Icons.shopping_bag),
          title: const Text('Beli Buku'),
          onTap: () {
            // Ke Beli Buku
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () async {
            // Ke Logout
            final response = await request.logout(
                // "https://flex-lib-e07-tk.pbp.cs.ui.ac.id/auth/logout_flutter/"
                "https://flex-lib.domcloud.dev/auth/logout_flutter/"
                // "http://127.0.0.1:8000/auth/logout_flutter/"
                );
            String message = response['message'];
            userData['is_login'] = false;
            userData['username'] = "";
            if (response['status'] == true) {
              if (!context.mounted) return;
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text("Berhasil Logout"),
                        content: Text(message),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("OK"))
                        ],
                      ));
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainRequestBuku(),
                  ));
            }
          },
        ),
      ],
    ));
  }
}
