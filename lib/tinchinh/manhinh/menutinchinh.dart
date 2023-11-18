import 'package:flutter/material.dart';
import 'package:tintuc/tinchinh/manhinh/tinchinh.dart';

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Icon(
                    Icons.fiber_new,
                    size: 30,
                  ),
                  Padding(padding: EdgeInsets.only(right: 5)),
                  Text(
                    'Tin chính',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Icon(Icons.notifications_none_outlined),
                      Text('20'),
                    ],
                  ),
                ),
                ClipOval(
                  child: Image.asset(
                    'assets/images/tantv.jpg',
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
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
              text: 'Mới nhất',

              // icon: Icon(Icons.home),
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
              text: 'Giải trí',
              // icon: Icon(Icons.beach_access_sharp),
            ),
          ],
          onTap: (index) {
            setState(() {
              if (tabData[index] == null) {
                switch (index) {
                  case 0:
                    tabData[index] = const Center(child: MoiNhat());
                    break;
                  case 1:
                    tabData[index] = const Center(child: Text('Việt Nam'));
                    break;
                  case 2:
                    tabData[index] = const Center(child: Text('Thế giới'));
                    break;
                  case 3:
                    tabData[index] = const Center(child: Text('Giải trí'));
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
            child: MoiNhat(),
          ),
          Center(
            child: Text('Việt Nam'),
          ),
          Center(
            child: Text('Thế giới'),
          ),
          Center(
            child: Text('Giải trí'),
          ),
        ],
      ),
    );
  }
}
