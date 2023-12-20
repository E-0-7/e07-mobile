import 'package:e07_mobile/authentication/register.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:e07_mobile/request_buku/screens/main_request_buku.dart';
import 'package:e07_mobile/request_buku/style/theme.dart';
import 'package:e07_mobile/katalog_buku/models/userstatus.dart';

Map<String, dynamic> userData = {"is_login": false, "username": ""};

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = false;
  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'asset/images/login_books.png',
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(height: 15.0),
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
                      decoration: InputDecoration(
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
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.blue),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                          ),
                          onPressed: () {
                            // Add your back function here
                            Navigator.pop(context);
                          },
                          child: const Text('Back'),
                        ),
                        OutlinedButton(
                          onPressed: () async {
                            String username = _usernameController.text;
                            String password = _passwordController.text;

                            // Cek kredensial
                            // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                            // final response = await request.login("http://127.0.0.1:8000/auth/login_flutter/", {
                            // final response = await request.login("https://flex-lib-e07-tk.pbp.cs.ui.ac.id/auth/login_flutter/", {

                            final response = await request.login(
                                //"http://localhost:8000/auth/login_flutter/",
                                "https://flex-lib.domcloud.dev/auth/login_flutter/",
                                {
                                  'username': username,
                                  'password': password,
                                });

                            if (request.loggedIn) {
                              if (!context.mounted) return;
                              Provider.of<UserStatusModel>(context,
                                      listen: false)
                                  .login(username);
                              String message = response['message'];
                              String uname = response['username'];
                              userData['is_login'] = true;
                              userData['username'] = uname;
                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainRequestBuku()),
                                );
                              });
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                      'Login Berhasil, Selamat Datang $uname'),
                                  content: Text(message),
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
                            } else {
                              if (!context.mounted) return;
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Login Gagal'),
                                  content: Text(response['message']),
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
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.blue),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                          ),
                          child: const Text('Login'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage()));
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.blue),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                          ),
                          child: const Text('Register'),
                        ),
                        const SizedBox(width: 20.0),
                      ],
                    )
                  ],
                ),
              ))),
    );
  }
}
