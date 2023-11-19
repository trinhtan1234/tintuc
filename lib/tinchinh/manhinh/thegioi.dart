import 'package:flutter/material.dart';
import 'package:tintuc/tinchinh/bloc/news_bloc.dart';
import 'package:tintuc/tinchinh/networking/models/model_news.dart';

class TheGioi extends StatefulWidget {
  const TheGioi({super.key});

  @override
  State<TheGioi> createState() => _TheGioiState();
}

class _TheGioiState extends State<TheGioi> {
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
              final tintucTheGioi =
                  news.where((news) => news.diadiem == 'Thế giới').toList();
              return ListView.builder(
                itemCount: tintucTheGioi.length,
                itemBuilder: (context, index) {
                  final news = tintucTheGioi[index];
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

class Container1 extends StatelessWidget {
  final ModelNews news;

  const Container1({required this.news, Key? key}) : super(key: key);

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
