import 'package:flutter/material.dart';

class MarkerInfoDialog extends StatelessWidget {
  final String name;
  final double coordinates;

  const MarkerInfoDialog(
      {super.key, required this.name, required this.coordinates});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Toạ độ : $coordinates'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
