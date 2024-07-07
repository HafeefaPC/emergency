import 'package:ambulance_call/screens/doctor_sec_page.dart';
import 'package:ambulance_call/screens/home.dart';
import 'package:ambulance_call/screens/user_page.dart';
import 'package:ambulance_call/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  Future<void> navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    var userType = prefs.getString('userType');

    if (username != null && userType != null) {
      if (userType == 'User') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else if (userType == 'Doctor') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DoctorPage()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Lottie.asset(
              'assets/animation/Ambu_Animation.json',
              width: 300,
              height: 400,
            ),
          ],
        ),
      ),
    );
  }
}
