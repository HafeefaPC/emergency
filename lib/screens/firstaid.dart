import 'package:flutter/material.dart';

class FirstAidPage extends StatefulWidget {
  const FirstAidPage({super.key});

  @override
  _FirstAidPageState createState() => _FirstAidPageState();
}

class _FirstAidPageState extends State<FirstAidPage> {
  String? _selectedCondition;
  final Map<String, String> _firstAidInfo = {
    'Stopped heart': 'Call emergency services immediately. Start CPR by giving 30 chest compressions followed by 2 rescue breaths.',
    'Snake Bite': 'Keep the person calm and still. Immobilize the bitten area and keep it lower than the heart. Seek medical help immediately.',
    'Stroke': 'Call emergency services immediately. Monitor the person’s breathing and provide comfort. Do not give anything to eat or drink.',
    'Bleeding': 'Apply direct pressure on the wound with a clean cloth. Elevate the injured area and keep pressure until help arrives.',
    'Choking': 'Perform the Heimlich maneuver by standing behind the person and giving upward thrusts just above the navel.',
    'Burns': 'Cool the burn under running water for at least 10 minutes. Cover with a sterile dressing and seek medical help if severe.',
    'Fracture': 'Immobilize the injured area and avoid moving the person. Apply a splint to support the fracture and seek medical help.',
    'Bee Sting': 'Remove the stinger by scraping with a card. Wash the area and apply ice to reduce swelling. Take an antihistamine if needed.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Aid Guide'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a condition to get first aid information:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedCondition,
              hint: const Text('Select a condition'),
              isExpanded: true,
              items: _firstAidInfo.keys.map((String condition) {
                return DropdownMenuItem<String>(
                  value: condition,
                  child: Text(condition),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCondition = newValue;
                });
              },
            ),
            const SizedBox(height: 24),
            if (_selectedCondition != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _firstAidInfo[_selectedCondition!]!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
