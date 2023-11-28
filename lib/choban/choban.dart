import 'package:flutter/material.dart';
import 'package:tintuc/tinchinh/bloc/news_bloc.dart';
import 'package:tintuc/tinchinh/manhinh/thoisu/chitiet_thoisu.dart';
import 'package:tintuc/tinchinh/networking/models/model_news.dart';

class ChoBan extends StatefulWidget {
  const ChoBan({Key? key}) : super(key: key);

  @override
  State<ChoBan> createState() => _ChoBanState();
}

class _ChoBanState extends State<ChoBan> {
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
              final thoiSuNewsList =
                  news.where((news) => news.loaitinbai == 'Thời sự').toList();
              final vietnamNewsList =
                  news.where((news) => news.loaitinbai == 'Việt Nam').toList();
              final thegioiNewsList =
                  news.where((news) => news.loaitinbai == 'Thế giới').toList();
              final giaitriNewsList =
                  news.where((news) => news.loaitinbai == 'Giải trí').toList();

              return ListView.builder(
                itemCount: thoiSuNewsList.length +
                    vietnamNewsList.length +
                    thegioiNewsList.length +
                    giaitriNewsList.length,
                itemBuilder: (context, index) {
                  if (index < thoiSuNewsList.length) {
                    return Container1(
                      news: thoiSuNewsList[index],
                      index: index,
                    );
                  } else if (index <
                      thoiSuNewsList.length + vietnamNewsList.length) {
                    return Container2(
                        news: vietnamNewsList[index - thoiSuNewsList.length]);
                  } else if (index <
                      thoiSuNewsList.length +
                          vietnamNewsList.length +
                          thegioiNewsList.length) {
                    return Container3(
                        news: thegioiNewsList[index -
                            thoiSuNewsList.length -
                            vietnamNewsList.length]);
                  } else {
                    return Container4(
                        news: giaitriNewsList[index -
                            thoiSuNewsList.length -
                            vietnamNewsList.length -
                            thegioiNewsList.length]);
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
enum SampleItem { Luu, Xem }

class Container1 extends StatefulWidget {
  final ModelNews news;
  final int index;

  const Container1({required this.news, required this.index, Key? key})
      : super(key: key);

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
      child: widget.index == 0
          ? Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              height: 550,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  if (widget.news.imagetieude != null &&
                      widget.news.imagetieude!.isNotEmpty)
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 20,
                        child: ClipRect(
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image(
                              image:
                                  NetworkImage(widget.news.imagetieude ?? ''),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width - 20,
                            ),
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
                  const Padding(padding: EdgeInsets.only(top: 0)),
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
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  Container(
                    height: 100,
                    color: Colors.white30,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.news.tieude ?? '').length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        // Kiểm tra nếu index lớn hơn hoặc bằng 1
                        return Container(
                          height: 80,
                          width: 230,
                          color: const Color.fromARGB(255, 243, 239, 239),
                          child: Center(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Title(
                                      color: Colors.black,
                                      child: Expanded(
                                        child: Text(widget.news.tieude ?? ''),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                ],
              ),
            )
          : Container(),
    );
  }
}

class Container2 extends StatelessWidget {
  final ModelNews? news;
  const Container2({Key? key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.yellow,
      // ignore: prefer_const_constructors
      child: Text('data2'),
    );
  }
}

class Container3 extends StatelessWidget {
  final ModelNews? news;
  const Container3({Key? key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.green,
      child: const Text('data2'),
    );
  }
}

class Container4 extends StatelessWidget {
  final ModelNews? news;
  const Container4({Key? key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.brown,
      child: const Text('data2'),
    );
  }
}
