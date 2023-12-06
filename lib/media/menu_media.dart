import 'package:flutter/material.dart';
import 'package:tintuc/choban/thongbao/thongbao.dart';
import 'package:tintuc/media/postcats.dart';
import 'package:tintuc/media/video.dart';

class TinTucMedia extends StatefulWidget {
  const TinTucMedia({super.key});

  @override
  State<TinTucMedia> createState() => _TinTucMediaState();
}

class _TinTucMediaState extends State<TinTucMedia>
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
              'Tin tức Media',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
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
            icon: const Icon(Icons.notifications_none_sharp),
          ),
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
              text: 'Video',
              // icon: Icon(Icons.beach_access_sharp),
            ),
            Tab(
              text: 'Postcats',
              // icon: Icon(Icons.beach_access_sharp),
            ),
          ],
          onTap: (index) {
            setState(() {
              if (tabData[index] == null) {
                switch (index) {
                  case 0:
                    tabData[index] = const Center(child: Video());
                    break;
                  case 1:
                    tabData[index] = const Center(child: Postcats());
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
            child: Video(),
          ),
          Center(
            child: Postcats(),
          ),
        ],
      ),
    );
  }
}