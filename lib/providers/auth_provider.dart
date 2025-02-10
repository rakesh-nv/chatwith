import 'package:chatwith/services/navigation_service.dart';
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
      SnackBarService.instance.showSnackBarSuccess('Welcome ${user?.email}');
      print('Logged in successfully');
      //update LastSeen Time
      NavigationService.instance.navigateToReplacement("home");
    } catch (e) {
      status = AuthStatus.Error;
      user = null;
      SnackBarService.instance.showSnackBarError('Error Authenticating');

      print('Login error: $e');
    }
    notifyListeners();
  }

  void registerUserWithEmailAndPassword(String _email, String _passoword,
      Future<void> onSuccess(String _uid)) async {
    status = AuthStatus.Authenticated;
    notifyListeners();
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _passoword);
      user = result.user;
      status = AuthStatus.Authenticated;
      await onSuccess(user!.uid);
      SnackBarService.instance.showSnackBarSuccess('Welcome ${user?.email}');
      // update LastSeen Time
      NavigationService.instance.goBack();
      NavigationService.instance.navigateToReplacement("home");
      // Navigate to home page
    } catch (e) {
      status = AuthStatus.Error;
      user = null;
      SnackBarService.instance.showSnackBarError('Error Registering User');
    }
    notifyListeners();
  }
}
