class News {
  String date;
  List<Story> stories;

  News({this.date, this.stories});

  @override
  String toString() {
    return 'News{date: $date, stories: $stories}';
  }
}

/// 新闻里的东西
class Story {
  bool dateType;
  String images;
  int type;
  int id;
  String gaPrefix;
  String title;

  Story(
      {this.gaPrefix,
      this.id,
      this.images,
      this.title,
      this.type,
      this.dateType = false});

  @override
  String toString() {
    return 'Story{images: $images, type: $type, id: $id, gaPrefix: $gaPrefix, title: $title}';
  }
}

class StoryDetail {
  String id;
  List<String> css;
  int type;
  List<String> images;

  /// ga_prefix
  String gaPrefix;
  List<String> js;

  /// share_url
  String shareUrl;
  String image;
  String title;

  /// image_source
  String imageSource;

  String body;

  StoryDetail(
      {this.id,
      this.css,
      this.type,
      this.images,
      this.gaPrefix,
      this.js,
      this.shareUrl,
      this.image,
      this.title,
      this.imageSource,
      this.body});

  @override
  String toString() {
    return 'StoryDetail{id: $id, css: $css, type: $type, images: $images, gaPrefix: $gaPrefix, js: $js, shareUrl: $shareUrl, image: $image, title: $title, imageSource: $imageSource}';
  }

}
