import 'package:flutter/material.dart';
import 'package:tintuc/caidat/caidat.dart';
import 'package:tintuc/danhsachbaiviet/danhsach.dart';
import 'package:tintuc/media/menu_media.dart';
import 'package:tintuc/tinchinhmoi/menutinchinh.dart';

class MenuKhungApp extends StatefulWidget {
  const MenuKhungApp({super.key});

  @override
  State<MenuKhungApp> createState() => _MenuKhungAppState();
}

class _MenuKhungAppState extends State<MenuKhungApp> {
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
      const DanhSachBaiViet(),
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
