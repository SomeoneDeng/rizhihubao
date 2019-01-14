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

  /// 获取某天之前的数据
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

  /// 获取detail
  Future<StoryDetail> getNewsDetail(String id) {
    Dio dio = new Dio();
    Future<Response> respFuture =
        dio.get("http://news-at.zhihu.com/api/3/news/" + id);
    return respFuture.then((resp) {
      return StoryDetail(
          title: resp.data['title'],
          shareUrl: resp.data['share_url'],
          type: resp.data['type'],
          image: resp.data['image'],
          gaPrefix: resp.data['ga_prefix'],
          imageSource: resp.data['image_source'],
          css: List.from(resp.data['css']),
          js: List.from(resp.data['js']),
          images: List.from(resp.data['images']),
          body: resp.data['body'],
          id: resp.data['id'].toString());
    });
  }
}
