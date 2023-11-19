import 'package:flutter/material.dart';
import 'package:tintuc/tinchinh/bloc/news_bloc.dart';
import 'package:tintuc/tinchinh/manhinh/thoisu/chitiet_thoisu.dart';
import 'package:tintuc/tinchinh/networking/models/model_news.dart';

class ThoiSu extends StatefulWidget {
  const ThoiSu({super.key});

  @override
  State<ThoiSu> createState() => _ThoiSuState();
}

class _ThoiSuState extends State<ThoiSu> {
  final NewsBloc _newsbloc = NewsBloc();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    _newsbloc.getNews();
  }

  @override
  void dispose() {
    _newsbloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<List<ModelNews>?>(
          stream: _newsbloc.newsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final news = snapshot.data!;
              final thoisuNewsList =
                  news.where((news) => news.loaitinbai == 'Thời sự').toList();
              return ListView.builder(
                itemCount: thoisuNewsList.length,
                itemBuilder: (context, index) {
                  final news = thoisuNewsList[index];
                  if (index == 0) {
                    return Container1(
                      news: news,
                    );
                  } else {
                    return Container2(news: news);
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

// ignore: constant_identifier_names
enum SampleItem { itemOne, itemTwo }

class Container1 extends StatefulWidget {
  final ModelNews news;

  const Container1({required this.news, Key? key}) : super(key: key);

  @override
  State<Container1> createState() => _Container1State();
}

class _Container1State extends State<Container1> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
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
            if (widget.news.imagetieude != null &&
                widget.news.imagetieude!.isNotEmpty) // Sửa thành articles
              SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: ClipRect(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image(
                      image: NetworkImage(
                          widget.news.imagetieude ?? ''), // Sửa thành articles
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width - 20,
                    ),
                  ),
                ),
              ),
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
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(widget.news.loaitinbai ?? ''),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.bookmark_border_outlined),
                  // ),
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
                            Text('Item ${index == 0}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}

class Container2 extends StatelessWidget {
  final ModelNews news;

  const Container2({required this.news, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            const Padding(padding: EdgeInsets.only(top: 5)),
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
            const Padding(padding: EdgeInsets.only(top: 5)),
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
            const Divider()
          ],
        ),
      ),
    );
  }
}
