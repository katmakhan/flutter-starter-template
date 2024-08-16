import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:app_name/Helpers/global_snackbar_get.dart';
import 'package:app_name/Login_Signup/login.dart';
import 'package:app_name/Login_Signup/otp.dart';
import 'package:app_name/Login_Signup/signup.dart';
import 'package:app_name/Main_Frags/frag_home.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  //Determine if the user is authenticated.
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            // User is already authenticated, navigate to the homepage.
            // return Homepage();
            return FragHome();
          } else {
            // User is not authenticated, navigate to the login page.
            return LoginPage();
          }
        });
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: <String>["email"]).signIn();

      if (googleUser == null) {
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on PlatformException catch (e) {
      if (e.code == GoogleSignIn.kNetworkError) {
        GlobalSnackBarGet().showGetError("Network Error", "No internet found");
      } else {
        GlobalSnackBarGet().showGetError("Error", e.message.toString());
      }
    }
  }

  signInWithApple() async {
    try {
      // Trigger the authentication flow
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create an OAuth credential using the obtained Apple ID credential
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Once signed in, return the UserCredential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      // Update the Firebase user profile with display name from Apple and a default profile picture URL
      final firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        print("Appleid givenname: ${appleCredential.givenName}");
        print("Appleid familyname: ${appleCredential.familyName}");
        print("Appleid email: ${appleCredential.email}");
        String appleemail = '${appleCredential.email ?? ''}}'.trim();
        String displayName =
            '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'
                .trim();
        String defaultPhotoUrl =
            'https://firebasestorage.googleapis.com/_Yourlocation_of_default_icon.png';

        if (displayName != "" && displayName != "null") {
          print("Updating display name:" + displayName);
          await firebaseUser.updateDisplayName(displayName);
        }
        await firebaseUser.updatePhotoURL(defaultPhotoUrl);
        if (appleemail != "" && appleemail != "null") {
          print("Updating apple email:" + appleemail);
          await firebaseUser.updateEmail(appleemail);
        }

        await firebaseUser.reload();
        return true;
      }
    } on PlatformException catch (e) {
      if (e.code == GoogleSignIn.kNetworkError) {
        GlobalSnackBarGet().showGetError("Network Error", "No internet found");
      } else {
        GlobalSnackBarGet().showGetError("Error", e.message.toString());
      }
      rethrow;
    } catch (e) {
      GlobalSnackBarGet().showGetError("Error", e.toString());
      rethrow;
    }
  }

  signInWithMobileOTP(bool loading, String number, context) async {
    FirebaseAuth.instance.verifyPhoneNumber(
      // phoneNumber: '+44 7123 123 456',
      phoneNumber: number,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        loading = false;
        GlobalSnackBarGet().showGetSucess("Sucess", "OTP Verified");
        FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        loading = false;
        if (e.code == 'invalid-phone-number') {
          GlobalSnackBarGet().showGetError("Error", 'Invalid Mobile Number');
        } else {
          print("Error is: ${e.message}");
          GlobalSnackBarGet().showGetError("Error", e.message.toString());
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        Singup.verifiId = verificationId;
        GlobalSnackBarGet().showGetSucess(
            "Sucess", 'Code sucessfully to mobile number $number');

        //Go to OTP entering Page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OTP(number)),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // GlobalSnackBarGet()
        //     .showGetError("Error", 'Code auto retrieval timeout');
      },
    );
  }

  verifyOtp(smsCode, context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: Singup.verifiId, smsCode: smsCode!);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);

      GlobalSnackBarGet().showGetSucess("Sucess", "Sucesssfully Logged In");

      //Login to homepage
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => Register()),
      //     (Route<dynamic> route) => false);
    } catch (e) {
      if (e.toString().contains("invalid-verification-code")) {
        GlobalSnackBarGet().showGetError("Error", "Invalid OTP");
      } else {
        GlobalSnackBarGet().showGetError("Error", "Something went wrong");
      }
    }
  }

  //Sign out
  logOut() {
    FirebaseAuth.instance.signOut();
  }
}
