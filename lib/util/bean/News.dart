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
  String images;
  int type;
  int id;
  String gaPrefix;
  String title;

  Story({this.gaPrefix, this.id, this.images, this.title, this.type});

  @override
  String toString() {
    return 'Story{images: $images, type: $type, id: $id, gaPrefix: $gaPrefix, title: $title}';
  }
}
