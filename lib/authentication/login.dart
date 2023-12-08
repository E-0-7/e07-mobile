import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:e07_mobile/request_buku/screens/main_request_buku.dart';
import 'package:e07_mobile/request_buku/style/theme.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    bool isPasswordVisible = false;
    void togglePasswordVisibility() {
      setState(() {
        isPasswordVisible = !isPasswordVisible;
      });
    }

    return Scaffold(

      body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: ThemeApp.darkTextTheme.displayLarge,
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      'Login to your account',
                      style: ThemeApp.darkTextTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12.0),

                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                      ),
                    ),
                    const SizedBox(height: 12.0),

                    TextField(
                      controller: _passwordController,
                      decoration:  InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            togglePasswordVisibility();
                          },
                          child: Icon(isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      obscureText: !isPasswordVisible,
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 20.0),
                        ElevatedButton(

                          onPressed: () {
                            // Add your back function here
                            Navigator.pop(context);
                          },
                          child: Text('Back'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            String username = _usernameController.text;
                            String password = _passwordController.text;

                            // Cek kredensial
                            // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                            // Untuk menyambungkan Android emulator dengan Django pada localhost,
                            // gunakan URL http://10.0.2.2/
                            final response = await request.login("http://127.0.0.1:8000/auth/login_flutter/", {
                              // final response = await request.login("https://thirza-ahmad-tugas.pbp.cs.ui.ac.id/auth/login/", {
                              'username': username,
                              'password': password,
                            });

                            if (request.loggedIn) {
                              String message = response['message'];
                              String uname = response['username'];
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => MainRequestBuku()),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                    SnackBar(content: Text("$message Selamat datang, $uname.")));
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Login Gagal'),
                                  content:
                                  Text(response['message']),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          child: const Text('Login'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Add your register function here
                          },
                          child: Text('Register'),
                        ),
                        const SizedBox(width: 20.0),
                      ],
                    )

                  ],
                ),
              )

          )

      ),
    );
  }
}