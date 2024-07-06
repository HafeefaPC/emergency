import 'package:flutter/material.dart';
import 'package:ambulance_call/screens/ambulance.dart';
import 'package:ambulance_call/screens/sos.dart';
import 'doctorpage.dart';
import 'firstaid.dart';
import 'poilce.dart';
import 'user_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Services'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildIconCard(
                    icon: Icons.local_hospital,
                    label: 'Ambulance',
                    backgroundColor: Colors.red,
                    context: context,
                    navigateTo: Ambulance(),
                  ),
                  _buildIconCard(
                    icon: Icons.person,
                    label: 'Doctor',
                    backgroundColor: Colors.green,
                    context: context,
                    navigateTo: DriverSecPage(),
                  ),
                  _buildIconCard(
                    icon: Icons.local_police,
                    label: 'Police',
                    backgroundColor: Colors.blue,
                    context: context,
                    navigateTo: PolicePage(),
                  ),
                  _buildIconCard(
                    icon: Icons.medical_services,
                    label: 'First Aid',
                    backgroundColor: Colors.yellow.shade700,
                    context: context,
                    navigateTo: FirstAidPage(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16), // Space between grid and SOS button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SOSButton()),
                );
              },
              icon: Icon(Icons.dangerous),
              label: Text('SOS'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconCard({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required BuildContext context,
    required Widget navigateTo,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigateTo),
        );
      },
      child: Card(
        color: backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
