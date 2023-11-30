import 'package:flutter/material.dart';
import 'package:tintuc/screen_nav_bottom.dart';

class TheoDoi extends StatefulWidget {
  const TheoDoi({super.key});

  @override
  State<TheoDoi> createState() => _TheoDoiState();
}

class _TheoDoiState extends State<TheoDoi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenNavigationBottom(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
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
        title: const Center(
          child: Text(
            'Theo dõi',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              const Divider(),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Chủ đề',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.add))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                              'Theo dõi các chủ đề để xem thêm tin bài về những nội dung bạn quan tâm trong chuyên mục Dành cho bạn.'),
                        ),
                        ClipOval(
                          child: Image.asset(
                            'assets/images/thiennhien.jpg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Nguồn tin',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.add))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                              'Theo dõi các nguồn tin để xem thêm tin bài về những nội dung bạn quan tâm trong chuyên mục Dành cho bạn.'),
                        ),
                        ClipOval(
                          child: Image.asset(
                            'assets/images/thiennhien.jpg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tin tức địa phương',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.add))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                              'Theo dõi các vị trí để xem thêm tin bài về những nội dung bạn quan tâm trong chuyên mục Dành cho bạn.'),
                        ),
                        ClipOval(
                          child: Image.asset(
                            'assets/images/thiennhien.jpg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tìm kiếm đã lưu',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text('Bạn chưa lưu tìm kiếm nào.'),
                        ),
                        ClipOval(
                          child: Image.asset(
                            'assets/images/thiennhien.jpg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tin bài đã lưu',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text('Chưa có tin bài nào lưu'),
                        ),
                        ClipOval(
                          child: Image.asset(
                            'assets/images/thiennhien.jpg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
