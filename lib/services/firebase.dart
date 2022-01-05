import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class FirebaseAuthentication {
  FirebaseAuthentication({required this.email, required this.password});

  late String password;
  late String email;

  void signUpUSer() {
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  void signInUser() {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  void forgotPasswordLink() {
    _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  void uploadProfileImage() {
    _firebaseAuth.currentUser!.photoURL;
  }
}
