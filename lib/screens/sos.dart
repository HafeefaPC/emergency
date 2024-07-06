import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Function to send an SMS using the url_launcher package with a predefined message
void _sendingSMS() async {
  // Define the phone number and the message body
  const String phoneNumber = '7356027036';
  const String message = 'I am in danger, help me';

  // Encode the message for URL format
  var url = Uri.parse('sms:$phoneNumber?body=${Uri.encodeComponent(message)}');

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class SOSButton extends StatelessWidget {
  const SOSButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOS Emergency'),
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning,
                color: Colors.red,
                size: 100.0,
              ),
              SizedBox(height: 20.0),
              const Text(
                'Emergency SOS',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton.icon(
                onPressed: _sendingSMS,
                icon: Icon(Icons.sms, color: Colors.white),
                label: Text('Send SMS'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.redAccent, // Button text color
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  textStyle: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


