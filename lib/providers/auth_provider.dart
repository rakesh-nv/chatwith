import 'package:chatwith/services/snackbar_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error,
}

class AuthProvider extends ChangeNotifier {
  User? user;
  AuthStatus status = AuthStatus.NotAuthenticated;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final AuthProvider instance = AuthProvider();

  AuthProvider();

  Future<void> loginUserWithEmailPassword(String email, String password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();

    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
      status = AuthStatus.Authenticated;
      SnackBarService.instance.showSnackBarSuccess('Welcom ${user?.email}');
      print('Logged in successfully');
    } catch (e) {
      status = AuthStatus.Error;
      SnackBarService.instance.showSnackBarError('Error Authenticating');

      print('Login error: $e');
    }
    notifyListeners();
  }
}
