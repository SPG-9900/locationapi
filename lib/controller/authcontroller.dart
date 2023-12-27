import 'package:assignment/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        // Navigate to the home page upon successful login
        Get.offAll(() => HomeScreen(user: user));

        // Show a green Snackbar for successful login
        Get.snackbar(
          'Login Successful',
          '',
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
        );
      }
    } catch (e) {
      print("Error: $e");
      // Handle login error and display a red Snackbar
      Get.snackbar(
        'Login Failed',
        e.toString(),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
