import 'package:flutter/material.dart';
import 'package:tintuc/caidat/screen_menu.dart';
import 'package:tintuc/choban/choban.dart';
import 'package:tintuc/tinchinh/manhinh/menutinchinh.dart';
import 'package:tintuc/postcasts/tinvideo.dart';

class ScreenNavigationBottom extends StatefulWidget {
  const ScreenNavigationBottom({super.key});

  @override
  State<ScreenNavigationBottom> createState() => _ScreenNavigationBottomState();
}

class _ScreenNavigationBottomState extends State<ScreenNavigationBottom> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _pages = [
      const ChoBan(),
      const MenuTinChinh(),
      const Postcasts(),
      const CaiDat(),
    ];
  }

  List<Widget> _pages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: 'Cho bạn'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Tin chính'),
          BottomNavigationBarItem(
              icon: Icon(Icons.headset_outlined), label: 'Postcasts'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài đặt'),
        ],
      ),
    );
  }
}
