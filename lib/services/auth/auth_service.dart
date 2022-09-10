import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  // initializing firebase auth
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  // this function will return current user information
  static User? get user => _auth.currentUser;

  // SignIn with email and password
  static Future<bool> signIn(String email, String password) async{
    // await _auth.useAuthEmulator('10.0.2.2',9099);
    try{
      print('sign in firebase');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('credential: $userCredential');
      return userCredential.user != null;
    }catch(error){
      print(error);
      return false;
    }

    // return AuthDB.isAdmin(userCredential.user!.uid);
  }

  // SignUp with email and password
  static Future<bool> signUp(String email, String password) async{
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
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

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