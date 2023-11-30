import 'package:flutter/material.dart';
import 'package:tintuc/screen_nav_bottom.dart';

class Postcasts extends StatelessWidget {
  const Postcasts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenNavigationBottom(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: ClipOval(
              child: Image.asset(
                'assets/images/tantv.jpg',
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        title: const Center(
          child: Text(
            'Postcasts',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
