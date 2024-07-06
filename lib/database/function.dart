import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model.dart'; // Make sure this import is correctly pointing to where your models (Login and Doctor) are defined

// Value Notifiers to manage the list of users and doctors
ValueNotifier<List<Login>> userList = ValueNotifier([]);
ValueNotifier<List<Doctor>> doctorList = ValueNotifier([]);

Future<void> addUser(User user) async {
  try {
   final userBox = await Hive.openBox<User>('userBox');
   await userBox.add(user);
    userList.notifyListeners();
  } catch (e) {
    print('Error opening doctorBox: $e');
    throw Exception('Failed to add doctor');
  }
}

// Return the list of users from Hive
Future<List<Login>> getUsersList() async {
  final userBox = await Hive.openBox<User>('userBox');
  
  List<Login> users = [];
  for (var user in userBox.values) {
    users.add(Login(
      username: user.name,
      password: user.password,
      mail: null, // Adjust as needed, since User does not have a 'mail' field
    ));
  }
  
  userList.value.clear();
  userList.value.addAll(users);
  userList.notifyListeners();
  
  return users;
}

Future<void> clearAllUsers() async {
  final userBox = await Hive.openBox<Login>('userBox');
  await userBox.clear();
  userList.value.clear();
  userList.notifyListeners();
}


Future<void> addDoctor(Doctor doctor) async {
  try {
    final doctorBox = await Hive.openBox<Doctor>('doctorBox');
    await doctorBox.add(doctor);
    doctorList.value.add(doctor);
    doctorList.notifyListeners();
  } catch (e) {
    print('Error opening doctorBox: $e');
    throw Exception('Failed to add doctor');
  }
}

// Function to retrieve all doctors from the Hive box and update the doctor list
Future<void> getDoctorList() async {
  final doctorBox = await Hive.openBox<Doctor>('doctorBox');
  doctorList.value.clear();
  doctorList.value.addAll(doctorBox.values);
  doctorList.notifyListeners();
}

// Function to clear all doctors from the Hive box and the doctor list
Future<void> clearAllDoctors() async {
  final doctorBox = await Hive.openBox<Doctor>('doctorBox');
  await doctorBox.clear();
  doctorList.value.clear();
  doctorList.notifyListeners();
}

void updateDoctorOnlineStatus(bool status) async {
  final doctorBox = await Hive.openBox<Doctor>('doctorBox');
  if (doctorBox.isNotEmpty) {
    Doctor? doctor = doctorBox.getAt(0); // Assuming you're updating the first doctor. Adjust index as needed.
    if (doctor != null) {
      doctor.onlineStatus = status;
      await doctor.save(); // Save the updated doctor back to Hive
    }
  }
}
