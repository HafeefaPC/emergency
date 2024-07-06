import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Ambulance extends StatefulWidget {
  const Ambulance({super.key});

  @override
  AmbulanceState createState() => AmbulanceState();
}

class AmbulanceState extends State<Ambulance> {
  @override
  void initState() {
    super.initState();
    // Initiate the call when the widget is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launchDialer('108');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calling Police'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text(
          'Dialing 108...',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  // Function to launch the dialer with the given number
  void _launchDialer(String number) async {
    final Uri dialUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(dialUri)) {
      await launchUrl(dialUri);
    } else {
      // Handle the error if the dialer cannot be opened
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch dialer')),
      );
    }
  }
}
