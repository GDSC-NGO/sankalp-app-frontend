import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ngo.dart';
import '../models/user.dart';
import '../repositories/ngo_repository.dart';
import '../repositories/user_repository.dart';

class AuthService {
  final UserRepository _userRepository = UserRepository();
  final NGORepository _ngoRepository = NGORepository();

  // User session management
  Future<void> saveUserSession(int userId, String username, bool isNgo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
    await prefs.setString('username', username);
    await prefs.setBool('isNgo', isNgo);
    await prefs.setBool('isLoggedIn', true);
  }

  Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('username');
    await prefs.remove('isNgo');
    await prefs.setBool('isLoggedIn', false);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<int?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  Future<bool> isCurrentUserNgo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isNgo') ?? false;
  }

  // Authentication operations
  Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String name,
    String? phone,
    String? address,
    required bool isNgo,
    NGO? ngoProfile,
  }) async {
    try {
      // Check if username or email already exists
      final usernameExists = await _userRepository.checkUsernameExists(
        username,
      );
      if (usernameExists) {
        throw Exception('Username already exists');
      }

      final emailExists = await _userRepository.checkEmailExists(email);
      if (emailExists) {
        throw Exception('Email already exists');
      }

      // Create user
      final user = User(
        username: username,
        email: email,
        password: password,
        // In production, hash this password
        name: name,
        phone: phone,
        address: address,
        isNgo: isNgo,
      );

      final userId = await _userRepository.insertUser(user);

      // If it's an NGO, create the NGO profile
      if (isNgo && ngoProfile != null) {
        final ngo = NGO(
          userId: userId,
          ngoName: ngoProfile.ngoName,
          description: ngoProfile.description,
          establishedYear: ngoProfile.establishedYear,
          registrationNumber: ngoProfile.registrationNumber,
          domain: ngoProfile.domain,
          website: ngoProfile.website,
          location: ngoProfile.location,
        );

        await _ngoRepository.insertNgoProfile(ngo);
      }

      // Save user session
      await saveUserSession(userId, username, isNgo);

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Registration error: $e');
      }
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      final user = await _userRepository.authenticateUser(username, password);

      if (user != null) {
        await saveUserSession(user.id!, user.username, user.isNgo);
        return true;
      }

      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      return false;
    }
  }

  Future<void> logout() async {
    await clearUserSession();
  }
}
