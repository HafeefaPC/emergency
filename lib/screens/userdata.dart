import 'package:ambulance_call/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../database/function.dart';
import '../database/model.dart';

ValueNotifier<List<Login>> UserList = ValueNotifier([]);

class UserDataInput extends StatefulWidget {
  const UserDataInput({Key? key}) : super(key: key);

  @override
  _UserDataInputState createState() => _UserDataInputState();
}

class _UserDataInputState extends State<UserDataInput> {
  late Box<Login> logindb;
  TextEditingController nameController1 = TextEditingController();
  TextEditingController phoneController1 = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  TextEditingController phoneController2 = TextEditingController();
  TextEditingController nameController3 = TextEditingController();
  TextEditingController phoneController3 = TextEditingController();

  int currentStep = 1;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    logindb = await Hive.openBox<Login>("logindb");
    await getUsersList(); // Retrieve initial data when box is opened
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (currentStep == 1) _buildUserInputField(1, nameController1, phoneController1),
            if (currentStep == 2) _buildUserInputField(2, nameController2, phoneController2),
            if (currentStep == 3) _buildUserInputField(3, nameController3, phoneController3),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addUser,
              child: Text(currentStep <= 3 ? 'Add User $currentStep' : 'Submit'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _clearAllUsers,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text('Clear All Users'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: _buildUserListView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInputField(int index, TextEditingController nameController, TextEditingController phoneController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Contact $index',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Name',
          ),
        ),
        SizedBox(height: 8.0),
        TextField(
          controller: phoneController,
          decoration: InputDecoration(
            labelText: 'Phone Number',
          ),
        ),
      ],
    );
  }

  void _addUser() {
    String name = '';
    String phone = '';

    if (currentStep == 1) {
      name = nameController1.text.trim();
      phone = phoneController1.text.trim();
    } else if (currentStep == 2) {
      name = nameController2.text.trim();
      phone = phoneController2.text.trim();
    } else if (currentStep == 3) {
      name = nameController3.text.trim();
      phone = phoneController3.text.trim();
    }

    if (name.isNotEmpty && phone.isNotEmpty) {
      final newUser = User(name: name,  phoneNumber: phone, password: phone); // Using 'mail' to store phone temporarily

      addUser(newUser).then((_) {
        getUsersList();
        setState(() {
          if (currentStep < 3) {
            currentStep++;
          } else {
            _submitAllUsers();
          }
        });
      });
    } else {
      _showErrorDialog(currentStep);
    }
  }

  void _submitAllUsers() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));// Assuming you have a route named '/home'
  }

  void _showErrorDialog(int userNumber) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Please enter both name and phone number for User $userNumber.'),
        actions: <Widget>[
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

  Future<void> _clearAllUsers() async {
    await clearAllUsers().then((_) {
      getUsersList();
      setState(() {
        currentStep = 1; // Reset the step to 1
        nameController1.clear();
        phoneController1.clear();
        nameController2.clear();
        phoneController2.clear();
        nameController3.clear();
        phoneController3.clear();
      });
    });
  }

  Widget _buildUserListView() {
    return ValueListenableBuilder<List<Login>>(
      valueListenable: UserList,
      builder: (context, userList, _) {
        if (userList.isEmpty) {
          return Center(
            child: Text('No users added yet.'),
          );
        }
        return ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            final user = userList[index];
            return ListTile(
              title: Text('User ${index + 1}: ${user.username}'),
              subtitle: Text('Phone: ${user.mail ?? ''}'),
            );
          },
        );
      },
    );
  }
}
