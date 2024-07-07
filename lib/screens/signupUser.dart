import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import '../database/function.dart';
import '../database/model.dart'; // Assuming your model.dart file is correctly located and imported
import 'login.dart';

class SignUpUser extends StatefulWidget {
  const SignUpUser({Key? key}) : super(key: key);

  @override
  State<SignUpUser> createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  void validate() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty && phoneNumber.isNotEmpty) {
      User newUser = User(name: username, password: password, phoneNumber: phoneNumber);

      try {
        await addUser(newUser);
        print('signup successful'); // Wait for addUser to complete
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return LoginPage(); // Navigate to login page after successful signup
        }));
      } catch (e) {
        // Handle any errors that occur during user addition
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to sign up. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent[100],
      appBar: AppBar(
        title: const Text("Sign Up User"),
        backgroundColor: Colors.redAccent[100],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 12), // Adjust the spacing between fields
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                ),
              ),
              const SizedBox(height: 12), // Adjust the spacing between fields
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 24), // Adjust the spacing before the button
              ElevatedButton(
                onPressed: validate,
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

