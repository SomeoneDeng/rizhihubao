import 'package:dio/dio.dart';
import 'package:rizhihubao/util/bean/News.dart';

class GetData {
  /// 获取news
  Future<News> getNews() {
    Dio dio = new Dio();
    Future<Response> respFuture =
        dio.get("http://news-at.zhihu.com/api/3/stories/latest");
    return respFuture.then((resp) {
      return News(
          date: resp.data['date'],
          stories: List.from((resp.data['stories'] as List).map((item) {
            return Story(
                title: item['title'],
                id: item['id'],
                gaPrefix: item['ga_prefix'],
                type: item['type'],
                images: item['images'][0]);
          })));
    });
  }

  Future<News> getNewsBefore(String date) {
    Dio dio = new Dio();
    Future<Response> respFuture =
    dio.get("http://news-at.zhihu.com/api/3/news/before/" + date);
    return respFuture.then((resp) {
      return News(
          date: resp.data['date'],
          stories: List.from((resp.data['stories'] as List).map((item) {
            return Story(
                title: item['title'],
                id: item['id'],
                gaPrefix: item['ga_prefix'],
                type: item['type'],
                images: item['images'][0]);
          })));
    });
  }
}
