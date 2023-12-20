import 'package:flutter/material.dart';

class UserStatusModel extends ChangeNotifier {
  String _userStatus = 'guest';

  String get userStatus => _userStatus;

  void login(String username) {
    _userStatus = username == "pustakawan" ? "pustakawan" : "loggedIn";
    notifyListeners();
  }

  void logout() {
    _userStatus = 'guest';
    notifyListeners();
  }
}
