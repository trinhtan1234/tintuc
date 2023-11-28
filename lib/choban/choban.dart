import 'package:flutter/material.dart';
import 'package:tintuc/tinchinh/bloc/news_bloc.dart';
import 'package:tintuc/tinchinh/networking/models/model_news.dart';

class ChoBan extends StatefulWidget {
  const ChoBan({super.key});

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
                    return Container1(news: thoiSuNewsList[index]);
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

class Container1 extends StatelessWidget {
  final ModelNews? news;
  const Container1({super.key, this.news});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Container2 extends StatelessWidget {
  final ModelNews? news;
  const Container2({super.key, this.news});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Container3 extends StatelessWidget {
  final ModelNews? news;
  const Container3({super.key, this.news});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Container4 extends StatelessWidget {
  final ModelNews? news;
  const Container4({super.key, this.news});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
