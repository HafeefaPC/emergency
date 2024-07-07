import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../database/model.dart';
import 'login.dart'; // Import your Login page file

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  bool switched = true;
  late Box<Doctor> doctorBox;

  @override
  void initState() {
    super.initState();
    // Initialize and open the Hive box
    doctorBox = Hive.box<Doctor>('doctorBox');
    // Fetch and set the initial state of the switch from the first doctor in the box
    if (doctorBox.isNotEmpty) {
      switched = doctorBox.getAt(0)?.onlineStatus ?? false;
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
                    title: Center(child: Text('Do you want to exit?')),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Doctor profile with status indicator
              Stack(
                children: [
                  // Large circle for doctor profile
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.grey[300], // Background color
                    child: Text(
                      'D', // Replace with doctor's name or initials
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Small circle for online/offline status
                  Positioned(
                    right: 4.0,
                    bottom: 4.0,
                    child: CircleAvatar(
                      radius: 10.0,
                      backgroundColor: switched ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              // Switch to toggle online status
              Switch(
                value: switched,
                onChanged: (bool value) {
                  setState(() {
                    switched = value;
                    // Update the online status in the Hive box
                    _updateDoctorOnlineStatus(value);
                  });
                },
              ),
              SizedBox(height: 10.0),
              Text(
                switched ? 'Online' : 'Offline',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: switched ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to update the online status in Hive
  void _updateDoctorOnlineStatus(bool status) async {
    if (doctorBox.isNotEmpty) {
      Doctor? doctor = doctorBox.getAt(0); // Assuming you're updating the first doctor. Adjust index as needed.
      if (doctor != null) {
        doctor.onlineStatus = status;
        await doctor.save(); // Save the updated status back to Hive
      }
    }
  }
}


