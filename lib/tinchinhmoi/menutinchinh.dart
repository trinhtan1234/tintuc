// import 'package:cloud_firestore/cloud_firestore.dart';
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

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // final TextEditingController _searchController = TextEditingController();
  // bool _isSearching = false;

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
          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const ThongBao(),
          //       ),
          //     );
          //   },
          //   icon: const Icon(Icons.add),
          // ),
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
        leading: const Icon(
          Icons.fiber_new,
          size: 30,
          color: Colors.deepPurple,
        ),
        // leading: Row(
        //   children: [
        //     IconButton(
        //       onPressed: () {
        //         _startSearch();
        //       },
        //       icon: Icon(Icons.search_outlined),
        //     ),
        //     if (_isSearching)
        //       SizedBox(
        //         width: 200, // Choose a suitable width
        //         child: Padding(
        //           padding: const EdgeInsets.all(8),
        //           child: TextField(
        //             controller: _searchController,
        //             decoration: InputDecoration(
        //               hintText: 'Tìm bài viết',
        //               suffixIcon: IconButton(
        //                 icon: const Icon(Icons.clear),
        //                 onPressed: () {
        //                   _endSearch();
        //                 },
        //               ),
        //             ),
        //             onSubmitted: (value) {
        //               searchData(value);
        //               _endSearch();
        //             },
        //           ),
        //         ),
        //       ),
        //     Expanded(
        //       child: IndexedStack(
        //         index: _currentIndex,
        //         children: tabData,
        //       ),
        //     ),
        //   ],
        // ),
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

  // Future<void> searchData(String searchTerm) async {
  //   try {
  //     QuerySnapshot querySnapshot = await _firestore
  //         .collection('bai_viet')
  //         .where('tieuDe', isEqualTo: searchTerm)
  //         .get();

  //     for (QueryDocumentSnapshot document in querySnapshot.docs) {
  //       Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  //       print(data);
  //     }
  //   } catch (e) {
  //     print('Error seaching data: $e');
  //   }
  // }

  // void _startSearch() {
  //   setState(() {
  //     _isSearching = true;
  //   });
  // }

  // void _endSearch() {
  //   setState(() {
  //     _isSearching = false;
  //     _searchController.clear();
  //   });
  // }
}
