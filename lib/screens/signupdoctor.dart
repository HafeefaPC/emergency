import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../database/model.dart';
import '../database/function.dart';
import 'login.dart';

class SignUpDoctor extends StatefulWidget {
  const SignUpDoctor({Key? key}) : super(key: key);

  @override
  _SignUpDoctorState createState() => _SignUpDoctorState();
}

class _SignUpDoctorState extends State<SignUpDoctor> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up as Doctor'),
        backgroundColor: Colors.redAccent[100], // Set custom background color
      ),
      backgroundColor: Colors.redAccent[100], // Set custom background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(_usernameController, 'Username'),
            SizedBox(height: 16),
            _buildTextField(_passwordController, 'Password', isPassword: true),
            SizedBox(height: 16),
            _buildTextField(_locationController, 'Location'),
            SizedBox(height: 16),
            _buildTextField(_phoneNumberController, 'Phone Number'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                signUpAsDoctor();
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
      ),
    );
  }

  void signUpAsDoctor() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String location = _locationController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();

    if (username.isNotEmpty &&
        password.isNotEmpty &&
        location.isNotEmpty &&
        phoneNumber.isNotEmpty) {
      Doctor newDoctor = Doctor(
        username: username,
        password: password,
        location: location,
        onlineStatus: false, // Example default value
        phoneNumber: phoneNumber,
      );

      try {
        await addDoctor(newDoctor);
        Fluttertoast.showToast(msg: 'Doctor signed up successfully');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (e) {
        print('Error signing up doctor: $e');
        Fluttertoast.showToast(msg: 'Failed to sign up doctor');
      }
    } else {
      Fluttertoast.showToast(msg: 'Please fill in all fields');
    }
  }
}
