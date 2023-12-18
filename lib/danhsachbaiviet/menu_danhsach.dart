import 'package:flutter/material.dart';
import 'package:tintuc/choban/thongbao/thongbao.dart';
import 'package:tintuc/danhsachbaiviet/danhsach.dart';
import 'package:tintuc/media/menu_media.dart';

class MenuDanhSachTinTuc extends StatefulWidget {
  const MenuDanhSachTinTuc({super.key});

  @override
  State<MenuDanhSachTinTuc> createState() => _MenuDanhSachTinTucState();
}

class _MenuDanhSachTinTucState extends State<MenuDanhSachTinTuc>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  List<Widget?> tabData = List.filled(2, null);

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fiber_new,
              size: 20,
              color: Colors.deepPurple,
            ),
            Padding(padding: EdgeInsets.only(right: 5)),
            Text(
              'Danh sách tin tức',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const ThongBao(),
          //       ),
          //     );
          //   },
          //   icon: const Icon(Icons.notifications_none_sharp),
          // ),
          TextButton(
            onPressed: () {},
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
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search_outlined,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: 'Tin tức',
            ),
            Tab(
              text: 'Tin tức Media',
            ),
          ],
          onTap: (index) {
            setState(() {
              if (tabData[index] == null) {
                switch (index) {
                  case 0:
                    tabData[index] = const Center(child: DanhSachBaiViet());
                    break;
                  case 1:
                    tabData[index] = const Center(child: TinTucMedia());
                    break;
                }
              }
              _currentIndex = index;
            });
          },
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const <Widget>[
          Center(
            child: DanhSachBaiViet(),
          ),
          Center(
            child: TinTucMedia(),
          ),
        ],
      ),
    );
  }
}
