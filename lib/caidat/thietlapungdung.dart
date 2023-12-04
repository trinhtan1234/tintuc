import 'package:flutter/material.dart';

class ThietLapUngDung extends StatefulWidget {
  const ThietLapUngDung({super.key});

  @override
  State<ThietLapUngDung> createState() => _ThietLapUngDungState();
}

class _ThietLapUngDungState extends State<ThietLapUngDung> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: MySwitch(),
      ),
    );
  }
}

class MySwitch extends StatefulWidget {
  const MySwitch({super.key});

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  String selectedValue = 'Option 1';
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DropdownButton<String>(
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value!;
            });
          },
          items: ['Option1', 'Option2', 'Option3'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 20,
        ),
        Switch(
          value: switchValue,
          onChanged: (value) {
            setState(() {
              switchValue = value;
            });
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Selected Value: $selectedValue\nSwitch State: ${switchValue ? 'On' : 'Off'}',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
