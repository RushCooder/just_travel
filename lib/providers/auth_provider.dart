import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_travel/apis/user_api.dart';
import 'package:just_travel/models/db-models/user_model.dart';

import '../services/auth/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool isObscure = true;
  bool isVisible = false;
  bool isSignOut = false;
  String? name, email, password, imagePath, mobileNumber, district, division;

  String errorMessage = '';
  Timer? timer;
  int emailResendTime = 59;
  bool isEmailVerified = false, isMobileVerified = false;
  bool? ensureEmailVerified;
  String? vId;

  String? genderGroupValue;
  num? dob;

  // change visibility of password
  void changeVisibility() {
    isVisible = !isVisible;
    isObscure = !isObscure;
    notifyListeners();
  }

  void setGenderGroupValue(String value) {
    genderGroupValue = value;
    notifyListeners();
  }

  void setDob(num dateTime){
    dob = dateTime;
    notifyListeners();
  }

  //set sign up info
  void setSignUpInfo(String name, String email, String password) {
    this.name = name;
    this.email = email;
    this.password = password;
  }

  //set sign up info
  void setContactInfo({
    required String imagePath,
    required String mobileNumber,
    required String district,
    required String division,
  }) {
    this.imagePath = imagePath;
    this.mobileNumber = mobileNumber;
    this.division = division;
    this.district = district;
  }

  // reset section/*
  // all reset*/
  void resetTimerValue() {
    if (timer != null) {
      timer!.cancel();
    }
    emailResendTime = 59;
    notifyListeners();
  }

  void reset() {
    name = null;
    email = null;
    password = null;
    imagePath = null;
    mobileNumber = null;
    district = null;
    division = null;
    genderGroupValue = null;
    dob = null;
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

  // start timer
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (emailResendTime > 0) {
        emailResendTime--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  // stop timer
  void stopTimer() {
    timer!.cancel();
  }

  Future<bool> deleteUser() async {
    try {
      await AuthService.deleteUser();
      return true;
    } catch (error) {
      print('delete firebase auth user: $error');
      return false;
    }
  }

  // checking email is verified or not
  Future<bool> checkEmailVerification() async {
    return await AuthService.checkIsVerified();
  }

// checking phone number verification. this method will return vId
  Future<void> verifyPhoneNumber(String phoneNumber,
      Function(String vId) codeSent, Function(String errorMsg) onError) async {
    await AuthService.verifyPhoneNumber(phoneNumber, codeSent, onError);
  }

  Future<bool> matchingSmsCode(String vId, String smsCode) async {
    try {
      if (await AuthService.matchingSmsCode(vId, smsCode)) {
        isMobileVerified = true;
        signOut();
        return true;
      } else {
        throw 'Wrong OTP';
      }
    } catch (error) {
      print('error at auth provider: $error');
      return false;
    }
  }

  // // signing in user
  // Future<void> _signIn() async {
  //   try {
  //     bool isSuccess = await AuthService.signIn(email!, password!);
  //     if (isSuccess) {
  //       return;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     rethrow;
  //   }
  // } //

  // //resend verification email
  // Future<void> reSendVerificationEmail() async {
  //   await AuthService.emailVerification();
  //   signOut();
  // }

  // SignUp user with email verification
  Future<bool> emailVerification() async {
    try {
      if (await AuthService.emailVerification()) {
        return true;
      }
      throw 'Email not verified';
    } catch (error) {
      print(error);
      return false;
    }
  }

  // authenticating user
  Future<bool> authenticate({required bool isSignUp}) async {
    try {
      bool status = false;
      if (isSignUp) {
        status = await AuthService.signUp(email!, password!);
      } else {
        status = await AuthService.signIn(email!, password!);
      }

      if (status) {
        return true;
      } else {
        AuthService.signOut();
        throw 'The password is invalid or the user does not have a password';
      }
    } on FirebaseAuthException catch (e) {
      setError(e.message!);
      return false;
    }
  }

  // sign in with google
  Future<bool> signInWithGoogle() async {
    try {
      UserCredential userCredential = await AuthService.signInWithGoogle();
      if (userCredential.user != null) {
        UserModel? registeredUser =
            await UserApi.fetchUserByEmail(userCredential.user!.email!);

        if (registeredUser == null) {
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

  // sign out
  Future<void> signOut() async {
    try {
      await AuthService.signOut();
      isSignOut = true;
      notifyListeners();
    } catch (error) {
      print('error sign out: $error');
    }
  }

  Future<void> storeInDataBase() async {
    UserModel? registeredUser = await UserApi.fetchUserByEmail(email!);
    UserModel? createdUser;
    if (registeredUser == null) {
      UserModel newUser = UserModel(
        name: name,
        email: Email(
          emailId: email,
          isVerified: isEmailVerified,
        ),
        mobile: Mobile(
          number: mobileNumber,
          isVerified: isMobileVerified,
        ),
        dob: dob,
        gender: genderGroupValue,
        district: district,
        division: division,
        profileImage: imagePath,
      );
      try {
        createdUser = await UserApi.createUser(newUser);
        if (createdUser == null) {
          deleteUser();
          signOut();
          throw 'Failed to create user';
        }
      } catch (e) {
        print('error for: $e');
        rethrow;
      }
    }
  }

  // sending password reset email using forgotPassword
  Future<bool> forgotPassword(String email) async {
    return await AuthService.forgotPassword(email);
  }

  // this method will return current user info
  User? getCurrentUser() => AuthService.user;
}
