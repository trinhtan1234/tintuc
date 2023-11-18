import 'dart:async';

import 'package:tintuc/tinchinh/networking/models/model_news.dart';
import 'package:tintuc/tinchinh/networking/responsitories/news_responsitory.dart';

class NewsBloc {
  final _newsbloc = NewsRepository();

  List<ModelNews>? news;

  final StreamController<List<ModelNews>?> _newsStreamController =
      StreamController<List<ModelNews>?>();
  Stream<List<ModelNews>?> get newsStream => _newsStreamController.stream;

  Future getNews() async {
    final listNewsTest = await _newsbloc.getNews();
    news = listNewsTest;
    _newsStreamController.sink.add(news);
  }

  void dispose() {
    _newsStreamController.close();
  }
}
