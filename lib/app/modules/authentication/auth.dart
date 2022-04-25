import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mycalendar/main.dart';

class Authentication {
  static Future<Pair> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    String? error;
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      error = catchAuthError(e);
    }

    return Pair(user, error);
  }

  static Future<Pair> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String? error;
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      error = catchAuthError(e);
    }

    return Pair(user, error);
  }

  static void logout() {
    FirebaseAuth.instance.signOut();
    close();
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }

  static String? catchAuthError(FirebaseAuthException e) {
    return e.message;
  }
}

class Pair {
  Pair(this.left, this.right);

  final dynamic left;
  final dynamic right;

  @override
  String toString() => 'Pair[$left, $right]';
}
