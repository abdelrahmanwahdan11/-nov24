import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../data/mock_user.dart';

class AuthController {
  static const _loggedInKey = 'logged_in';
  final ValueNotifier<UserProfile?> user = ValueNotifier<UserProfile?>(null);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool(_loggedInKey) ?? false;
    if (loggedIn) {
      user.value = mockUser;
    }
  }

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    user.value = mockUser;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, true);
    return true;
  }

  Future<void> logout() async {
    user.value = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInKey);
  }

  Future<bool> register(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    user.value = UserProfile(
      name: name,
      email: email,
      avatarUrl: mockUser.avatarUrl,
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, true);
    return true;
  }
}
