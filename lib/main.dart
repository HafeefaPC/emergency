import 'package:ambulance_call/screens/home.dart';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'database/model.dart'; // Assuming this file contains Hive models like Login, Doctor, User
import 'screens/signupUser.dart';
import 'screens/signupdoctor.dart';
import 'splash_screen.dart'; // Assuming this is your splash screen widget

Future<void> main() async {
  // Load environment variables from .env file
  
  
  // Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for Flutter
  await Hive.initFlutter();
  
  // Register Hive adapters for your custom models
  Hive.registerAdapter(LoginAdapter());   // typeId: 1
  Hive.registerAdapter(DoctorAdapter());  // typeId: 2
  Hive.registerAdapter(UserAdapter());    // typeId: 3
  
  // Open Hive boxes for storing data
  await Hive.openBox<Doctor>('doctorBox');
  await Hive.openBox<Login>('logindb');
  
  // Run the application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomeScreen(),
    );
  }
}
