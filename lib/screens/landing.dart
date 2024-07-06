import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'signupUser.dart';
import 'signupdoctor.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent[100], // Set the background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
            SizedBox(height: 20), // Add some space between animation and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return SignUpUser();
                      }));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0), // Square shape
                    ),
                    minimumSize: Size(150, 50), // Width and height of the button
                  ),
                  child: Text('Sign Up as User'),
                ),
                SizedBox(width: 20), // Space between the two buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return SignUpDoctor();
                      }));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0), // Square shape
                    ),
                    minimumSize: Size(150, 50), // Width and height of the button
                  ),
                  child: Text('Sign Up as Doctor'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
