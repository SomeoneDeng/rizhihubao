import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rizhihubao/util/bean/News.dart';

class NewsListView extends StatefulWidget {
  News news;

  NewsListView(this.news);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewsListViewState(news);
  }
}

class _NewsListViewState extends State<NewsListView> {
  News news;

  _NewsListViewState(this.news);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: List.from(news.stories.map((i) => NewsListViewItem(
            story: i,
          ))),
    );
  }
}

/// 首页的新闻列表的一个item
class NewsListViewItem extends StatelessWidget {
  final Story story;

  NewsListViewItem({this.story});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("id: ${story.id}");
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                story.title,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Image.network(
              story.images,
              scale: 2,
            ),
          ],
        ),
      ),
    );
  }
}