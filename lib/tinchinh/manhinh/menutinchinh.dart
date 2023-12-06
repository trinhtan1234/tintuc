import 'package:flutter/material.dart';
import 'package:tintuc/caidat/login/thongtintaikhoan.dart';
import 'package:tintuc/choban/thongbao/thongbao.dart';
import 'package:tintuc/tinchinh/manhinh/kinhdoanh.dart';
import 'package:tintuc/tinchinh/manhinh/thegioi.dart';
import 'package:tintuc/tinchinh/manhinh/thoisu/thoisu.dart';
import 'package:tintuc/tinchinh/manhinh/vietnam.dart';

class MenuTinChinh extends StatefulWidget {
  const MenuTinChinh({super.key});

  @override
  State<MenuTinChinh> createState() => _MenuTinChinhState();
}

class _MenuTinChinhState extends State<MenuTinChinh>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  List<Widget?> tabData = List.filled(4, null);

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
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
              size: 30,
              color: Colors.deepPurple,
            ),
            Padding(padding: EdgeInsets.only(right: 5)),
            Text(
              'Tin chính',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThongBao(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThongBao(),
                ),
              );
            },
            icon: const Icon(Icons.notifications_none_sharp),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThongTinTaiKhoan(),
                ),
              );
            },
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
              icon: Icon(Icons.fiber_new),
            ),
            Tab(
              text: 'Việt Nam',
              // icon: Icon(Icons.beach_access_sharp),
            ),
            Tab(
              text: 'Thế giới',
              // icon: Icon(Icons.beach_access_sharp),
            ),
            Tab(
              text: 'Kinh doanh',
              // icon: Icon(Icons.beach_access_sharp),
            ),
          ],
          onTap: (index) {
            setState(() {
              if (tabData[index] == null) {
                switch (index) {
                  case 0:
                    tabData[index] = const Center(child: ThoiSu());
                    break;
                  case 1:
                    tabData[index] = const Center(child: VietNam());
                    break;
                  case 2:
                    tabData[index] = const Center(child: TheGioi());
                    break;
                  case 3:
                    tabData[index] = const Center(child: Kinhdoanh());
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
            child: ThoiSu(),
          ),
          Center(
            child: VietNam(),
          ),
          Center(
            child: TheGioi(),
          ),
          Center(
            child: Kinhdoanh(),
          ),
        ],
      ),
    );
  }
}
