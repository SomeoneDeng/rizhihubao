import 'package:flutter/material.dart';
import 'package:rizhihubao/util/GetData.dart';
import 'package:rizhihubao/util/bean/News.dart';
import 'package:rizhihubao/views/NewsListView.dart';

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


  @override
  void initState() {
    super.initState();
    getNews();
    title = "首页";
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: Text(title),
          actions: <Widget>[],
        ),
        body: Container(
          child: news == null ? null : NewsListView(news)
        ),
        drawer: Drawer(child: ListView(children: <Widget>[
          Text("asdasd")
        ],)),
      ),
    );
  }

  void getNews() {
    print("getting news...");
    GetData().getNews().then((n) {
      setState(() {
        news = n;
      });
    });
  }
}
