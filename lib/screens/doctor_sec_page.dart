import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../database/model.dart';
import 'login.dart'; // Import your Hive model file

class doctorpage extends StatefulWidget {
  const doctorpage({super.key});

  @override
  State<doctorpage> createState() => _doctorpageState();
}

class _doctorpageState extends State<doctorpage> {
  bool switched = true;
  late Box<Doctor> doctorBox; // Declare a Box for Driver objects

  @override
  void initState() {
    super.initState();
    // Initialize and ope Drivers
    doctorBox = Hive.box<Doctor>('doctorBox');
    // Optionally, you can fetch and set the initial state of the switch from a specific driver
    // For example, get the first driver in the box and use their online status
    if (doctorBox.isNotEmpty) {
      switched = doctorBox.getAt(0)?.onlineStatus ?? false; // Adjust index as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[100],
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctxt) {
                  return AlertDialog(
                    title: Center(child: Text('Do you want to exit ?')),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctxt) {
                            return const LoginPage();
                          }));
                        },
                        child: const Text(
                          'Yes',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.exit_to_app),
            iconSize: 30,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Switch(
              value: switched,
              onChanged: (bool value) {
                setState(() {
                  switched = value;
                  // Update the onlinestatus in the Hive box
                  _updateDoctorOnlineStatus(value);
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  // Function to update the onlinestatus in Hive
  void _updateDoctorOnlineStatus(bool status) async {
    if (doctorBox.isNotEmpty) {
      Doctor? doctor = doctorBox.getAt(0); // Assuming you're updating the first driver. Adjust index as needed.
      if (doctor != null) {
        doctor. onlineStatus= status;
        
        await doctor.save(); // Save the updated status back to Hive
      }
    }
  }
}
