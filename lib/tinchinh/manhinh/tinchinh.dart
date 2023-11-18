import 'package:flutter/material.dart';
import 'package:tintuc/tinchinh/bloc/news_bloc.dart';
import 'package:tintuc/tinchinh/networking/models/model_news.dart';

class MoiNhat extends StatefulWidget {
  const MoiNhat({super.key});

  @override
  State<MoiNhat> createState() => _MoiNhatState();
}

class _MoiNhatState extends State<MoiNhat> {
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
              return ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  // final article = articles[index];
                  if (index == 0) {
                    return Container1(news: news[index]);
                  } else {
                    return Container2(news: news[index]);
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
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      height: (news.imagetieude != null && news.imagetieude!.isNotEmpty)
          ? 400
          : 200,
      // color: Colors.blue,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          const Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            children: [
              Flexible(
                child: Text(
                  news.tieude ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 3,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  news.noidung ?? '',
                  maxLines: 4,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(''),
              IconButton(
                onPressed: () {},
                icon: const Row(
                  children: [
                    Icon(
                      Icons.visibility,
                      color: Colors.red,
                    ),
                    // const Padding(padding: EdgeInsets.only(right: 15)),
                    Text(''),
                  ],
                ),
              ),
            ],
          ),

          // const Padding(padding: EdgeInsets.only(top: 10)),
          const Divider(
            height: 0,
            thickness: 10,
            color: Color.fromARGB(255, 233, 228, 228),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          // const Padding(padding: EdgeInsets.only(top: 10)),
        ],
      ),
    );
  }
}

class Container2 extends StatelessWidget {
  final ModelNews news;

  const Container2({required this.news, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      height: (news.imagetieude != null && news.imagetieude!.isNotEmpty)
          ? 400
          : 200,
      // color: Colors.blue,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          const Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            children: [
              Flexible(
                child: Text(
                  news.tieude ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 3,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  news.noidung ?? '',
                  maxLines: 4,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(''),
              IconButton(
                onPressed: () {},
                icon: const Row(
                  children: [
                    Icon(
                      Icons.visibility,
                      color: Colors.red,
                    ),
                    // const Padding(padding: EdgeInsets.only(right: 15)),
                    Text(''),
                  ],
                ),
              ),
            ],
          ),

          // const Padding(padding: EdgeInsets.only(top: 10)),
          const Divider(
            height: 0,
            thickness: 10,
            color: Color.fromARGB(255, 233, 228, 228),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          // const Padding(padding: EdgeInsets.only(top: 10)),
        ],
      ),
    );
  }
}
