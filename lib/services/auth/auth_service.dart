import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // initializing firebase auth
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  // this function will return current user information
  static User? get user => _auth.currentUser;

  // reload user
  static Future<void> get reload => _auth.currentUser!.reload();

  // checking isVerified
  static Future<bool> checkIsVerified () async {
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
      return userCredential.user != null;
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

  // phone number verification
  static Future<void> verifyPhoneNumber(String phoneNumber, Function(String vId) codeSent) async {

    await _auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        print('phone number verified');
        print('phone number verified: ${credential}');
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        print('verify id sent: $verificationId');
        codeSent(verificationId);
        // vId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    // return vId;
  }

  static Future<bool> matchingSmsCode(String vId, String smsCode) async{
    try{
      final PhoneAuthCredential credential =
      PhoneAuthProvider.credential(verificationId: vId, smsCode: smsCode);

      UserCredential userCredential = await _auth.signInWithCredential(credential);

      print('credential have: $credential');
      print('user credential have: $userCredential');
      return userCredential.user != null ? true : false;
    }
    catch(error){
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
