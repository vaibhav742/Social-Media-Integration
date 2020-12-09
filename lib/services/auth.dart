import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

abstract class AuthBase {
  User get currentUser;
  Stream<User> authStateChanges();
  Future<User> signInAnonymously();
    Future<User> signInWithFacebook();

  // Future<User> signInWithGoogle();
  Future<void> signOut();
}

class Auth implements AuthBase {

  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  // @override
  // Future<User> signInWithGoogle() async {
  //   final googleSignIn = GoogleSignIn();
  //   final googleUser = await googleSignIn.signIn();
  //   if (googleUser != null) {
  //     final googleAuth = await googleUser.authentication;
  //     if (googleAuth.idToken != null) {
  //       final userCredential = await _firebaseAuth
  //           .signInWithCredential(GoogleAuthProvider.credential(
  //         idToken: googleAuth.idToken,
  //         accessToken: googleAuth.accessToken,
  //       ));
  //       return userCredential.user;
  //     } else {
  //       throw FirebaseAuthException(
  //         code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
  //         message: 'Missing Google ID Token',
  //       );
  //     }
  //   } else {
  //     throw FirebaseAuthException(
  //       code: 'ERROR_ABORTED_BY_USER',
  //       message: 'Sign in aborted by user',
  //     );
  //   }

  

 
  Future<User>signInWithFacebook()async{
    final fb=FacebookLogin();
    final response =await fb.logIn(
      permissions: [
        FacebookPermission.publicProfile,
                FacebookPermission.email,


      ]
    );
    switch (response.status){
    case FacebookLoginStatus.Success:
    final accessToken=response.accessToken;
    final userCredential=await _firebaseAuth.signInWithCredential(
      FacebookAuthProvider.credential(accessToken.token),
    );
    return userCredential.user;
    case FacebookLoginStatus.Cancel:
    throw FirebaseAuthException(
      code: 'ERROR_ABORTED_BY_USER',
      message: 'SIGN IN ABORTED BY USER',
    );
    case FacebookLoginStatus.Error:
    throw FirebaseAuthException(
      code: 'ERROR_FACEBOOK_LOGIN_FAILED',
      message: response.error.developerMessage,
    );
    default:
    throw UnimplementedError();

  }
  }

  @override
  Future<void> signOut() async {
    final facebookLogin=FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}