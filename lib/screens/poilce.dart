import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PolicePage extends StatefulWidget {
  const PolicePage({super.key});

  @override
  _PolicePageState createState() => _PolicePageState();
}

class _PolicePageState extends State<PolicePage> {
  @override
  void initState() {
    super.initState();
    // Initiate the call when the widget is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launchDialer('100');
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
          'Dialing 100...',
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
