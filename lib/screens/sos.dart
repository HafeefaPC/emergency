import 'package:flutter/material.dart';


class SOSButton extends StatefulWidget {
  const SOSButton({Key? key}) : super(key: key);

  @override
  State<SOSButton> createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton> {
  // String message = "I am in danger, please contact me back!";
  // List<String> recipients = ["+918547046415", "+917736761186", "+917994995080"];

  // String _resultMessage = "";

  // void _sendSMS(String message, List<String> recipients) async {
  //   try {
  //     String _result = await sendSMS(message: message, recipients: recipients);
  //     setState(() {
  //       _resultMessage = "SMS sent successfully: $_result";
  //     });
  //   } catch (error) {
  //     setState(() {
  //       _resultMessage = "Error sending SMS: $error";
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAF9F6),
      appBar: AppBar(
        title: Text("Send SOS SMS"),
        centerTitle: true,
        backgroundColor:Colors.redAccent[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
               
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              
              label: Text(
                " SOS message sented to your emergency contacts",
                style: TextStyle(color: Colors.white, fontSize: 17.0),
              ),
            ),
            SizedBox(height: 20),
            // Text(_resultMessage),
          ],
        ),
      ),
    );
  }
}
