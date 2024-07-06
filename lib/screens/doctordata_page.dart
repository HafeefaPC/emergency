import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../database/model.dart';
import 'doctor_sec_page.dart';

class doctor extends StatefulWidget {
  const doctor({super.key});

  @override
  State<doctor> createState() => _doctorState();
}

class _doctorState extends State<doctor> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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
                child: Lottie.asset('assets/animation/welcome.json'),
              ),
              Container(
                height: 50,
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                child: TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Location',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                child: TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Phone number',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  validate();
                },
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validate() {
    final name = _nameController.text;
    final location = _locationController.text;
    final phoneNumber = _phoneController.text;

    if (name.isEmpty || location.isEmpty || phoneNumber.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill all fields');
      return;
    }

    final doctor = Doctor(username: name, location: location, phoneNumber: phoneNumber, password: '', onlineStatus: false);
    Hive.box<Doctor>('doctorBox').add(doctor);

    Fluttertoast.showToast(msg: 'Added successfully');
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const doctorpage();
    }));
  }
}
