import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tintuc/caidat/login/thongtintaikhoan.dart';
import 'package:tintuc/tinchinhmoi/kinhdoanh.dart';
import 'package:tintuc/tinchinhmoi/thegioi.dart';
import 'package:tintuc/tinchinhmoi/tintuc.dart';
import 'package:tintuc/tinchinhmoi/tinvietnam.dart';

class MenuTinChinh extends StatefulWidget {
  const MenuTinChinh({super.key});

  @override
  State<MenuTinChinh> createState() => _MenuTinChinhState();
}

class _MenuTinChinhState extends State<MenuTinChinh>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  List<Widget> tabData = [
    const TinTuc(),
    const VietNam(),
    const TheGioi(),
    const KinhDoanh(),
  ];

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
    final User? currentUser = FirebaseAuth.instance.currentUser;
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const ThongBao(),
              //   ),
              // );
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const ThongBao(),
              //   ),
              // );
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
              child: currentUser?.photoURL != null
                  ? Image.network(
                      currentUser?.photoURL ?? '',
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.person),
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
            ),
            Tab(
              text: 'Thế giới',
            ),
            Tab(
              text: 'Kinh doanh',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: tabData,
      ),
    );
  }
}
