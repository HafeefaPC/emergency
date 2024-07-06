import 'package:hive_flutter/hive_flutter.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class Login extends HiveObject {
  @HiveField(0)
  final String username;

  @HiveField(1)
  String? mail;

  @HiveField(2)
  final String password;

  Login({required this.username, required this.password, this.mail});
}

@HiveType(typeId: 2)
class Doctor extends HiveObject {
  @HiveField(0)
  final String username;

  @HiveField(1)
  String? mail;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String location;

  @HiveField(4)
   bool onlineStatus;

  @HiveField(5) // New field for phoneNumber
  final String phoneNumber;

  Doctor({
    required this.username,
    required this.password,
    this.mail,
    required this.location,
    required this.onlineStatus,
    required this.phoneNumber,
  });
}

@HiveType(typeId: 3)
class User extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String phoneNumber;

   @HiveField(2)
  final String password;

  User({required this.name, required this.password,required this.phoneNumber});
}
