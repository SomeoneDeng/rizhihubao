import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rizhihubao/util/GetData.dart';
import 'package:rizhihubao/util/bean/News.dart';
import 'package:date_format/date_format.dart';

class NewsListView extends StatefulWidget {
  News news;

  NewsListView({this.news});

  @override
  State<StatefulWidget> createState() {
    return _NewsListViewState(news: news);
  }
}

class _NewsListViewState extends State<NewsListView> {
  News news;
  bool isPerformingRequest;
  ScrollController _scrollController;
  String date;

  @override
  void initState() {
    super.initState();
    date = news.date;
    isPerformingRequest = false;
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _NewsListViewState({this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListView(
        controller: _scrollController,
        children: List.from(news.stories.map((i) => NewsListViewItem(
              story: i,
            ))),
      ),
    );
  }

  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      var nowdate = DateTime.parse(news.date);
      var lastday = nowdate.add(Duration(days: -1));
      print("last date: $lastday");
      GetData().getNewsBefore(formatDate(lastday, [yyyy, mm, dd])).then((n) {
        setState(() {
          news.stories.addAll(n.stories);
          print("new date: ${n.date}");
          news.date = n.date;
          isPerformingRequest = false;
        });
      });
    }
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
      child: Card(
          child: Container(
        padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
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
      )),
    );
  }
}
