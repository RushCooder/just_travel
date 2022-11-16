import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // initializing firebase auth
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  // this function will return current user information
  static User? get user => _auth.currentUser;

  static const String collectionAdmin = 'admins';
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  // this method will check the uid with admins collection from firebase firestore
  // then will return true or false
  static Future<bool> isAdmin(String uid) async {
    DocumentSnapshot snapshot =
    await _firebaseFirestore.collection(collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }

  // delete user
  static Future<bool> deleteUser() async {
    try {
      await user?.delete();
      return true;
    } catch (error) {
      print('delete firebase auth user: $error');
      return false;
    }
  }


  // reload user
  static Future<void> get reload => _auth.currentUser!.reload();

  // checking isVerified
  static Future<bool> checkIsVerified() async {
    await reload;
    return user!.emailVerified;
  }

  // SignIn with email and password
  static Future<bool> signIn(String email, String password) async {
    // await _auth.useAuthEmulator('10.0.2.2',9099);
    try {
      print('sign in firebase');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('credential: $userCredential');
      return await AuthService.isAdmin(userCredential.user!.uid) == false;
    } catch (error) {
      print(error);
      return false;
    }

    // return AuthDB.isAdmin(userCredential.user!.uid);
  }

  // SignUp user with email verification
  static Future<bool> emailVerification() async {
    try {
      await user!.sendEmailVerification();
      print('verificaiton email sent');

      return true;
    } catch (error) {
      print(error);
      return false;
    }

    // return AuthDB.isAdmin(userCredential.user!.uid);
  }

  // sending password reset email using forgotPassword
  static Future<bool> forgotPassword(String email) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e){
      debugPrint('password reset email sending failed: $e');
      return false;
    }

  }

  // phone number verification
  static Future<void> verifyPhoneNumber(
      String phoneNumber, Function(String vId) codeSent, Function(String errorMsg) onError) async {
    await _auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        print('phone number verified');
        print('phone number verified: ${credential}');
      },
      verificationFailed: (FirebaseAuthException e) {
        print('verification failed: $e');
        onError(e.message!);
      },
      codeSent: (String verificationId, int? resendToken) {
        print('verify id sent: $verificationId');
        codeSent(verificationId);
        // vId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    // return vId;
  }

  static Future<bool> matchingSmsCode(String vId, String smsCode) async {
    try {
      final PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: vId, smsCode: smsCode);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      print('credential have: $credential');
      print('user credential have: $userCredential');
      return userCredential.user != null ? true : false;
    } catch (error) {
      print('Wrong OTP');
      return false;
    }
  }

  // SignUp with email and password
  static Future<bool> signUp(String email, String password) async {
    // await _auth.useAuthEmulator('10.0.2.2',9099);
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print('credential: $userCredential');
    return userCredential.user != null;
    // return AuthDB.isAdmin(userCredential.user!.uid);
  }

  // SignIn With Google
  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<void> signOut() => _auth.signOut();
}
