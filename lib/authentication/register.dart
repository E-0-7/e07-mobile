import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:e07_mobile/request_buku/style/theme.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.blue,
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
                'Register',
                style: ThemeApp.darkTextTheme.displayLarge,
              ),
              const SizedBox(height: 24.0),
              Text(
                'Register a new account',
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
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        String username = _usernameController.text;
                        String password = _passwordController.text;

                        // TODO: Change the URL to the deployment URL
                        final response = await http.post(
                            Uri.parse(
                                "http://localhost:8000/auth/register_flutter/"),
                            body: {'username': username, 'password': password});

                        final data = json.decode(response.body);

                        if (data["status"]) {
                          if (!context.mounted) return;
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                                SnackBar(content: Text(data["message"])));
                        } else {
                          if (!context.mounted) return;
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Register Gagal'),
                              content: Text(data['message']),
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
                      child: const Text("Register")),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Back")),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
