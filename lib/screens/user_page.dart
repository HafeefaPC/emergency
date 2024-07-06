 import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/model.dart';
import 'doctorpage.dart'; // Import your DoctorPage or DoctorScreen widget
import 'doctor_sec_page.dart';
import 'user_sec_screen.dart'; // Assuming this is another screen/widget

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int _currentIndex = 0;
  String? _username;

  final List<Widget> _screens = [
    DriverSecPage(),
    Search(),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _initHiveBoxes(); // Ensure boxes are initialized in initState
  }

  Future<void> _loadUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
    });
  }

  Future<void> _initHiveBoxes() async {
    try {
      await Hive.openBox<Doctor>('driverBox');
      await Hive.openBox<Login>('logindb');
      // Add more boxes as needed
    } catch (e) {
      print('Error initializing Hive boxes: $e');
      // Handle errors as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $_username'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blueGrey,
        backgroundColor: Colors.red,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
      body: _screens[_currentIndex],
    );
  }
}
