import 'package:assignment/controller/authcontroller.dart';
import 'package:assignment/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Use GetMaterialApp instead of MaterialApp
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      initialBinding: AuthBinding(), // Initialize AuthController
    );
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
