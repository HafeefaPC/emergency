import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/model.dart';

import 'doctor_sec_page.dart';
import 'doctordata_page.dart';
import 'home.dart';
import 'landing.dart';
import 'signupUser.dart';
import 'userdata.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? selectedValue;

  Future<void> validate() async {
    if (selectedValue == 'User') {
      await validateUser();
    } else if (selectedValue == 'Doctor') {
      try {
        await validateDoctor();
      } catch (e) {
        print('Error validating doctor: $e');
        Fluttertoast.showToast(msg: "Error validating doctor");
      }
    }
  }

  Future<void> validateUser() async {
  try {
    final logindb = await Hive.openBox<User>('normalUserBox');
    bool isLoggedIn = false;

    for (var user in logindb.values) {
      if (user.name == _usernameController.text &&
          user.password == _passwordController.text) {
        isLoggedIn = true;
        break;
      }
    }

    if (isLoggedIn) {
      loginInfo();
      Fluttertoast.showToast(msg: "Login successfully");

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return UserDataInput();
      }));
    } else {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return  UserDataInput();
      }));
    }
  } catch (e) {
    print('Error validating user: $e');
    Fluttertoast.showToast(msg: "Error logging in");
  }
}

  Future<void> validateDoctor() async {
    try {
      final doctorBox = await Hive.openBox<Doctor>('doctorBox');
      bool isLoggedIn = false;

      for (var doctor in doctorBox.values) {
        if (doctor.username == _usernameController.text &&
            doctor.password == _passwordController.text) {
          isLoggedIn = true;
          break;
        }
      }

      if (isLoggedIn) {
        loginInfo();
        Fluttertoast.showToast(msg: "Login successfully");

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return DoctorPage(); // Replace with your doctor's landing page
        }));
      } else {
        Fluttertoast.showToast(msg: "Invalid credentials");
      }
    } catch (e) {
      print('Error opening doctorBox: $e');
      Fluttertoast.showToast(msg: "Error logging in");
    }
  }

  void loginInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _usernameController.text);
    prefs.setString('userType', selectedValue ?? '');
  }

  List<DropdownMenuItem<String>> getDropdownMenuItems() {
    List<String> items = ['User', 'Doctor'];
    return items.map((String item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: const TextStyle(color: Colors.black87),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 250,
                height: 250,
                child: Lottie.asset('assets/animation/lottti.json'),
              ),
              Container(
                height: 50,
                child: TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButton<String>(
                  icon: const Icon(Icons.account_circle),
                  hint: const Text(
                    'Select Login',
                    style: TextStyle(color: Colors.black87),
                  ),
                  iconSize: 20,
                  iconEnabledColor: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                  style: const TextStyle(color: Colors.white),
                  items: getDropdownMenuItems(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  value: selectedValue,
                ),
              ),
              ElevatedButton(
                onPressed: selectedValue == null
                    ? null
                    : () {
                        validate();
                      },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("New user? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return LandingPage();
                      }));
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
