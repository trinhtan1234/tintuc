import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:tintuc/choban/theodoi/theodoi.dart';
import 'package:tintuc/choban/thongbao/thongbao.dart';
=======

import 'package:tintuc/theodoi/theodoi.dart';
>>>>>>> 740dd6fcd672b35ac05155396a22a2567dc3da34
import 'package:tintuc/tinchinh/bloc/news_bloc.dart';
import 'package:tintuc/tinchinh/manhinh/thoisu/chitiet_thoisu.dart';
import 'package:tintuc/tinchinh/manhinh/thoisu/thoisu.dart';

import '../tinchinh/networking/models/model_news.dart';

class ChoBan extends StatefulWidget {
  const ChoBan({super.key});

  @override
  State<ChoBan> createState() => _ChoBanState();
}

class _ChoBanState extends State<ChoBan> {
  final NewsBloc newsbloc = NewsBloc();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    newsbloc.getNews();
  }

  @override
  void dispose() {
    newsbloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () {},
          child: const Row(
            children: [
              Icon(
                Icons.newspaper,
                color: Colors.red,
              ),
              Expanded(
                child: Text(
                  'Tin của bạn',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TheoDoi(),
                ),
              );
            },
<<<<<<< HEAD
            icon: const Row(
              children: [
                Icon(Icons.add),
                Text('Theo dõi'),
              ],
            ),
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
=======
            icon: const Icon(
              Icons.library_add,
              color: Colors.red,
            ),
>>>>>>> 740dd6fcd672b35ac05155396a22a2567dc3da34
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: ClipOval(
                child: Image.asset(
                  'assets/images/tantv.jpg',
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: newsbloc.newsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final news = snapshot.data!;

              // final tintucTheGioi =
              // news.where((news) => news.diadiem == 'Thời sự').toList();
              return ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  if (news.isNotEmpty) {
                    // final List<ModelNews> news = snapshot.data!;
                    return Man1(news: news[index]);
                  } else {
                    return Man2(news: news[index]);
                  }
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class Man1 extends StatelessWidget {
  final ModelNews news;
  const Man1({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChiTietThoiSu(
              news: news,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        height: 550,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            // const Padding(padding: EdgeInsets.only(top: 5)),
            if (news.imagetieude != null &&
                news.imagetieude!.isNotEmpty) // Sửa thành articles
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  child: ClipRect(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image(
                        image: NetworkImage(
                            news.imagetieude ?? ''), // Sửa thành articles
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width - 20,
                      ),
                    ),
                  ),
                ),
              ),
            // const Padding(padding: EdgeInsets.only(top: 5)),
            Row(
              children: [
                Expanded(
                  child: Text(
                    news.tieude ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
            // const Padding(padding: EdgeInsets.only(top: 5)),
            Text(
              news.ngaytao?.toString() ?? '',
              style: const TextStyle(fontSize: 12),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            Row(
              children: [
                Expanded(
                  child: Text(
                    news.noidung ?? '',
                    maxLines: 3,
                  ),
                ),
              ],
            ),
            // const Padding(padding: EdgeInsets.only(top: 5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(news.loaitinbai ?? ''),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border_outlined),
                ),
              ],
            ),
<<<<<<< HEAD
            const Divider(),
=======
>>>>>>> 740dd6fcd672b35ac05155396a22a2567dc3da34
          ],
        ),
      ),
    );
  }
}

class Man2 extends StatefulWidget {
  final ModelNews news;

  const Man2({required this.news, Key? key}) : super(key: key);

  @override
  State<Man2> createState() => _Man2State();
}

class _Man2State extends State<Man2> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    SampleItem? selectedMenu;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChiTietThoiSu(
              news: widget.news,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        height: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 5)),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.news.tieude ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            Text(
              widget.news.ngaytao?.toString() ?? '',
              style: const TextStyle(fontSize: 12),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.news.noidung ?? '',
                    maxLines: 3,
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            if (widget.news.imagetieude != null &&
                widget.news.imagetieude!.isNotEmpty) // Sửa thành articles
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  child: ClipRect(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image(
                        image: NetworkImage(widget.news.imagetieude ??
                            ''), // Sửa thành articles
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width - 20,
                      ),
                    ),
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(widget.news.loaitinbai ?? ''),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Row(
                          children: [
                            Icon(
                              Icons.comment_outlined,
                              color: Colors.red,
                            ),
                            Text(
                              '22',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )),
                    MenuAnchor(
                      builder: (BuildContext context, MenuController controller,
                          Widget? child) {
                        return IconButton(
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          icon: const Icon(Icons.bookmark_border_outlined),
                          tooltip: 'Show menu',
                        );
                      },
                      menuChildren: List<MenuItemButton>.generate(
                        2,
                        (int index) => MenuItemButton(
                          onPressed: () => setState(
                              () => selectedMenu = SampleItem.values[index]),
                          child: Row(
                            children: [
                              Text('Lưu ${index == 0}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
