import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  static const _isLoggedInKey = 'isLoggedIn';
  static const _isLibrarianKey = 'isLibrarian';

  Future<void> setUserStatus(bool isLoggedIn, bool isLibrarian) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, isLoggedIn);
    await prefs.setBool(_isLibrarianKey, isLibrarian);
  }

  Future<String> getUserStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    bool isLibrarian = prefs.getBool(_isLibrarianKey) ?? false;

    if (isLoggedIn) {
      return isLibrarian ? 'pustakawan' : 'loggedIn';
    } else {
      return 'guest';
    }
  }
}
