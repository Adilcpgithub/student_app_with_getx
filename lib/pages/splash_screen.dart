import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/pages/home_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Image.asset(
            "assets/AddStudent.jpg",
          ),
        ),
      ),
    );
  }
}

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    gotoHomeScreen();
  }

  Future<void> gotoHomeScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAll(HomeScreen());
  }
}
