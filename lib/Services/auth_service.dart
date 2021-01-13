import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
        (User user) => user?.uid,
      );

  // // GET UID
  // Future<String> getCurrentUID() async {
  //   return (_firebaseAuth.currentUser).uid;
  // }

  // // GET CURRENT USER
  // Future getCurrentUser() async {
  //   return _firebaseAuth.currentUser;
  // }

  // Email & Password Sign Up
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    // Update the username
    await updateUserName(name, authResult.user);
    return authResult.user.uid;
  }

  Future updateUserName(String name, User currentUser) async {
    await currentUser.updateProfile(displayName: name);
    await currentUser.reload();
  }

  // Email & Password Sign In
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email.trim(), password: password))
        .user
        .uid;
  }

  // Sign Out
  signOut() async {
    return await _firebaseAuth.signOut();
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}

class NameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 3) {
      return "Naam moet minsten 3 karakters lang zijn";
    }
    if (value.length > 20) {
      return "Naam mag niet langer zijn dan 20 karakters";
    }
    return null;
  }
}

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Email mag niet leeg zijn";
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Wachtwoord mag niet leeg zijn";
    }
    return null;
  }
}
