import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SplashScreenPageController extends GetxController {
  var showImage = false.obs;


  var userName="".obs;
  var userInfo="".obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // The user canceled the sign-in
      print('Sign-in was canceled by the user.');
      throw Exception('Sign-in canceled by user');
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOutWithGoogle() async {
    await GoogleSignIn().signOut(); // Sign out from Google
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase
    print('User signed out');
  }

  void printUserData(User? user) {
    if (user != null) {
      userName(user.displayName);

      userInfo("""
      'User signed in:'
      'Display Name: ${user.displayName}'
      'Photo URL: ${user.photoURL}'
      'UID: ${user.uid}'
      'phoneNumber: ${user.phoneNumber}'
      'emailVerified: ${user.emailVerified}'
      'tenantId: ${user.tenantId}'
      'refreshToken: ${user.refreshToken}'
      """);


      print('User signed in:');
      print('Display Name: ${user.displayName}');
      print('Email: ${user.email}');
      print('Photo URL: ${user.photoURL}');
      print('UID: ${user.uid}');
    } else {
      print('User is null. Sign-in might have failed.');
    }
  }
}
