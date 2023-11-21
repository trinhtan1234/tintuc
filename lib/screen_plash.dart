import 'package:flutter/material.dart';

class ScreenFlash extends StatelessWidget {
  const ScreenFlash({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.9],
          colors: [
            Color(0xFFFC5C7D),
            Color(0xFF6A82FB),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 90.0),
      child: Image.asset(
        'assets/images/tantv.jpg',
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
