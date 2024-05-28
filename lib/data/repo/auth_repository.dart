import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hidjab_user/utils/exceptions/exceptions.dart';

import '../response/network_response.dart';

class AuthRepository {
  Future<NetworkResponse> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return NetworkResponse(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return NetworkResponse(
        errorText: LogInWithEmailAndPasswordFailure.fromCode(e.code).message,
        errorCode: e.code,
      );
    } catch (error) {
      return NetworkResponse(
        errorText: "An unknown exception occurred.$error",
      );
    }
  }

  Future<NetworkResponse> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return NetworkResponse(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return NetworkResponse(
        errorText: SignUpWithEmailAndPasswordFailure.fromCode(e.code).message,
        errorCode: e.code,
      );
    } catch (_) {
      return NetworkResponse(
        errorText: "An unknown exception occurred.",
      );
    }
  }

  Future<NetworkResponse> googleSignIn() async {
    try {
      late final AuthCredential credential;
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser!.authentication;
      credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return NetworkResponse(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return NetworkResponse(
          errorCode: LogInWithGoogleFailure.fromCode(e.code).message);
    } catch (_) {
      return NetworkResponse(
        errorText: "An unknown exception occurred.",
      );
    }
  }

  logOutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
