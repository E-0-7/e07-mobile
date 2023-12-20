import 'package:e07_mobile/drawer/left_drawer.dart';
import 'package:e07_mobile/request_buku/style/theme.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tentang Kami"),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Center(
              child: Text(
                "Tentang Kami",
                style: ThemeApp.lightTextTheme.displayLarge,
              ),
            ),
            Text(
              "Flex-lib",
              style: ThemeApp.lightTextTheme.displayLarge,
            ),
            Text(
              "E07 / PBP E",
              style: ThemeApp.lightTextTheme.displayMedium,
            ),
            const SizedBox(height: 20.0),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Dalam era digital saat ini, tantangan literasi bukan hanya sebatas aksesibilitas buku, tetapi juga bagaimana memotivasi masyarakat untuk terlibat aktif dalam budaya membaca. Sebagai respons terhadap kondisi sosial yang menunjukkan adanya penurunan minat baca, diperkenalkan sebuah inovasi digital bernama Flex-lib. Kita memutuskan untuk menggunakan nama Flex-lib karena kita membuat sebuah aplikasi literasi yang dapat diakses darimana saja dan kapan saja sehingga sangat fleksibel. Aplikasi web ini merupakan simbol harapan baru bagi pecinta buku dan mereka yang ingin mendalami dunia literasi. Flex-lib menawarkan fitur Katalog Buku yang memudahkan pengguna untuk menelusuri koleksi buku berdasarkan berbagai kategori dan preferensi. Bagi mereka yang ingin menambah koleksi pribadi, fitur Beli Buku siap menyajikan pilihan buku baru maupun bekas dengan harga terjangkau. Namun, jika pengguna hanya ingin menikmati buku dalam jangka waktu tertentu, fitur Pinjam Buku memungkinkan mereka untuk meminjam buku tanpa harus mengeluarkan biaya besar. Menyadari betapa berharganya setiap buku dan pentingnya mendistribusikan ilmu kepada yang membutuhkan, Flex-lib memfasilitasi fitur Donasi Buku, di mana masyarakat dapat berdonasi atau menerima buku dari donatur lainnya. Selain itu, fitur Request Buku memungkinkan pengguna untuk meminta buku tertentu yang belum ada dalam katalog, menggambarkan bagaimana aplikasi ini berupaya memenuhi kebutuhan literasi setiap individu. Dengan Flex-lib, kita bukan hanya menghadirkan buku ke hadapan masyarakat, tetapi juga mengajak masyarakat datang kepada buku, merangkul mereka dalam budaya literasi, dan membangun jembatan pengetahuan yang lebih inklusif dan kolaboratif.",
                  style: ThemeApp.lightTextTheme.bodySmall,
                )),
            const SizedBox(height: 20.0),
            Center(
              child: Text(
                "Anggota Kami",
                style: ThemeApp.lightTextTheme.displayMedium,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("BimanToro Widyadana",
                          style: ThemeApp.lightTextTheme.bodyMedium),
                      Text(
                        "22060824306",
                        style: ThemeApp.lightTextTheme.bodyMedium,
                      ),
                      Text(
                        "Donasi Buku & Register",
                        style: ThemeApp.lightTextTheme.bodyMedium,
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Caesar Justitio",
                          style: ThemeApp.lightTextTheme.bodyMedium),
                      Text(
                        "2206082373",
                        style: ThemeApp.lightTextTheme.bodyMedium,
                      ),
                      Text(
                        "Beli Buku",
                        style: ThemeApp.lightTextTheme.bodyMedium,
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Devin Faiz Faturahman",
                          style: ThemeApp.lightTextTheme.bodyMedium),
                      Text(
                        "2206830593",
                        style: ThemeApp.lightTextTheme.bodyMedium,
                      ),
                      Text(
                        "Pinjam Buku",
                        style: ThemeApp.lightTextTheme.bodyMedium,
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Ricky Setiawan",
                          style: ThemeApp.lightTextTheme.bodyMedium),
                      Text(
                        "2206083161",
                        style: ThemeApp.lightTextTheme.bodyMedium,
                      ),
                      Text(
                        "Katalog Buku",
                        style: ThemeApp.lightTextTheme.bodyMedium,
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Thirza Ahmad Tsaqif",
                          style: ThemeApp.lightTextTheme.bodyMedium),
                      Text(
                        "2206082556",
                        style: ThemeApp.lightTextTheme.bodyMedium,
                      ),
                      Text(
                        "Request Buku & Login",
                        style: ThemeApp.lightTextTheme.bodyMedium,
                      )
                    ],
                  ),
                ])),
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
