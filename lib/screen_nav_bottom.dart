import 'package:flutter/material.dart';
import 'package:tintuc/caidat/caidat.dart';
import 'package:tintuc/media/menu_media.dart';
import 'package:tintuc/taobaiviet/tapbaiviet.dart';
import 'package:tintuc/tinchinh/manhinh/menutinchinh.dart';

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
      const MenuTinChinh(),
      const TinTucMedia(),
      TaoBaiViet(),
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Tin chính'),
          BottomNavigationBarItem(
              icon: Icon(Icons.headset_outlined), label: 'Media'),
          BottomNavigationBarItem(
              icon: Icon(Icons.post_add_outlined), label: 'Tạo bài viết'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài đặt'),
        ],
      ),
    );
  }
}
