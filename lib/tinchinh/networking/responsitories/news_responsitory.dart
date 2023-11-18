import 'package:tintuc/tinchinh/networking/api_url/url.dart';
import 'package:tintuc/tinchinh/networking/models/model_news.dart';
import 'package:tintuc/tinchinh/networking/responsitories/http_service.dart';

class NewsRepository {
  final HttpService _server = HttpService();

  Future<List<ModelNews>?> getNews() async {
    try {
      final response = await _server.request(UrlApp.getNews);
      final dataResponse = response?.data;
      if (dataResponse != null) {
        return modelNewsFromJson(dataResponse);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
