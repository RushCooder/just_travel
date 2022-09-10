import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:just_travel/apis/user_api.dart';
import 'package:just_travel/models/db-models/user_model.dart';

import '../services/auth/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool isObscure = true;
  bool isVisible = false;
  bool isSignOut = false;
  String? email;
  String? password;
  String errorMessage = '';

  // change visibility of password
  void changeVisibility() {
    isVisible = !isVisible;
    isObscure = !isObscure;

    print('obscure: $isObscure');
    notifyListeners();
  }

  // set email from email field
  void setEmail(String email) {
    this.email = email;
  }

  // set password from password field
  void setPassword(String password) {
    this.password = password;
  }

  void setError(String err) {
    errorMessage = err;
    notifyListeners();
  }

  // signing in admin
  Future<void> _signIn() async {
    try {
      bool isSuccess = await AuthService.signIn(email!, password!);
      if (isSuccess) {
        return;
      }
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  // authenticating admin
  Future<void> authenticate({required bool isSignUp}) async {
    try {
      bool status = false;
      if (isSignUp) {
        print('signup calling');
        status = await AuthService.signUp(email!, password!);
      } else {
        status = await AuthService.signIn(email!, password!);
      }

      if (!status) {
        AuthService.signOut();
        throw 'Credential error';
      }
    } on FirebaseAuthException catch (e) {
      setError(e.message!);
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      UserCredential userCredential = await AuthService.signInWithGoogle();
      print('user credential: $userCredential');
      if (userCredential.user != null) {
        UserModel? registeredUser =
            await UserApi.fetchUserByEmail(userCredential.user!.email!);

        if (registeredUser == null) {

          print('creating new user');

          UserModel newUser = UserModel(
            name: userCredential.user!.displayName,
            email: Email(
              emailId: userCredential.user!.email,
              isVerified: userCredential.user!.emailVerified,
            ),
          );
          await UserApi.createUser(newUser);
        }
        return true;
      } else {
        throw Error();
      }
    } catch (error) {
      print('auth provider sign in with google: $error');
      return false;
    }
  }

  Future<void> signOut() async {
    try{
      await  AuthService.signOut();
      isSignOut = true;
      notifyListeners();
    }catch(error){
      print('error sign out: $error');
    }

  }

  // this method will return current user info
  User? getCurrentUser() => AuthService.user;
}
