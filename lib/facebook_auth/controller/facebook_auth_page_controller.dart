import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FaceBookAuthPageController extends GetxController {
  var showImage = false.obs;
  var userName = "".obs;
  var userInfo = "".obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // Facebook Sign-in Method
  Future<UserCredential?> signInWithFacebook1() async {
    try {
      isLoading.value = true;  // Show loading indicator

      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      log('Login Result: ${loginResult.status}');

      // Check login result status
      if (loginResult.status == LoginStatus.success) {
        log('Access Token: ${loginResult.accessToken!.tokenString}');

        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

        // Once signed in, return the UserCredential
        final userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

        log('Facebook sign-in successful: ${userCredential.user?.displayName}');

        // Optionally, update user info (can be used later in the app)
        userName.value = userCredential.user?.displayName ?? '';
        userInfo.value = """
          'User signed in:'
          'Display Name: ${userCredential.user?.displayName}'
          'Email: ${userCredential.user?.email}'
          'Photo URL: ${userCredential.user?.photoURL}'
          'UID: ${userCredential.user?.uid}'
        """;

        return userCredential;
      } else {
        log('Facebook login failed: ${loginResult.message}');
        throw Exception('Facebook login failed: ${loginResult.message}');
      }
    } catch (e) {
      log('Error during Facebook sign-in: $e');
      // Optionally, update UI with error message or handle specific exceptions
      return null;
    } finally {
      isLoading.value = false;  // Hide loading indicator
    }
  }


  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email', 'public_profile'],);

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential("${loginResult.accessToken?.tokenString}");

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  // Sign-out from Facebook and Firebase
  Future<void> signOutWithFacebook() async {
    try {
      await FacebookAuth.instance.logOut();
      await FirebaseAuth.instance.signOut();
      log('User signed out');
    } catch (e) {
      log('Error during Facebook sign-out: $e');
    }
  }
}
