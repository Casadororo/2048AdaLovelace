import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Auth change Stream
  Stream<User> get user {
    return _auth.onAuthStateChanged;
  }

  User get userUser{
    return _auth.currentUser;
  }

  //Login with Google
  Future<User> singInGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName + " uid " + user.uid);
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void logout() {
    _googleSignIn.signOut();
    _auth.signOut();
  }
}