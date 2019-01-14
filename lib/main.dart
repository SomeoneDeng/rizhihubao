import 'package:flutter/material.dart';
import 'package:rizhihubao/util/GetData.dart';
import 'package:rizhihubao/util/bean/News.dart';
import 'package:rizhihubao/views/NewsListView.dart';
import 'package:date_format/date_format.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  void getNews() {
    var getData = new GetData();
    getData.getNews().then((news) {});
  }

  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<MyApp> {
  News news;
  String title;

  int swipIndex;

  @override
  void initState() {
    super.initState();
    getNews();
    title = "首页";
    swipIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text("News"),
        ),
        body: news == null
            ? Text("Loading")
            : NewsListView(
                news: news,
              ),
        drawer: Drawer(
            child: ListView(
          children: <Widget>[Text("Drawer")],
        )),
      ),
    );
  }

  void getNews() {
    GetData()
        .getNewsBefore(formatDate(DateTime.now(), [yyyy, mm, dd]))
        .then((n) {
      setState(() {
        news = n;
        print(news.date);
      });
    });
  }
}
