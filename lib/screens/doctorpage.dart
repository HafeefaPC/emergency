import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../database/model.dart'; // Adjust import path as per your project structure

class DriverSecPage extends StatefulWidget {
  const DriverSecPage({Key? key}) : super(key: key);

  @override
  _DriverSecPageState createState() => _DriverSecPageState();
}

class _DriverSecPageState extends State<DriverSecPage> {
  late Box<Doctor> doctorBox;
  List<Doctor> doctors = []; // Initialize an empty list of doctors

  @override
  void initState() {
    super.initState();
    _openDoctorBoxAndLoadData(); // Open box and load data on initialization
  }

  Future<void> _openDoctorBoxAndLoadData() async {
    doctorBox = await Hive.openBox<Doctor>('doctorBox');
    loadDoctorList();
  }

  void loadDoctorList() {
    setState(() {
      doctors = doctorBox.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor List'),
      ),
      body: _buildDoctorList(),
    );
  }

  Widget _buildDoctorList() {
    if (doctors.isEmpty) {
      return Center(
        child: Text('No doctors available.'),
      );
    } else {
      return ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          Doctor doctor = doctors[index];
          return ListTile(
            title: Text(doctor.username),
            subtitle: Text(doctor.location),
            trailing: Icon(Icons.phone),
            onTap: () {
              // Implement onTap action here, like making a phone call
              _makePhoneCall(doctor.phoneNumber);
            },
          );
        },
      );
    }
  }


  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
