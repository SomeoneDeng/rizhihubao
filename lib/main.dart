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
          title: Text("日知乎报"),
        ),
        body: news == null
            ? Text("Loading")
            : NewsListView(
                news: news,
              ),
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            Container(
              child: ListTile(
                title: Text("这是个Demo"),
                subtitle: Text(
                  "someone",
                  textAlign: TextAlign.right,
                ),
              ),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("access/img/drawer_head.jpg"))),
              height: 200,
            ),
            ListTile(
              title: Text("iamdqncoder@gmail.com"),
              leading: Icon(Icons.mail),
            ),
            ListTile(
              title: Text("https://www.moha.moe"),
              leading: Icon(Icons.web),
            )
          ],
        )),
      ),
    );
  }

  void getNews() {
    GetData()
        .getNewsBefore(formatDate(DateTime.now(), [yyyy, mm, dd]))
        .then((n) {
      setState(() {
        n.stories.insert(0, Story(dateType: true, title: n.date));
        news = n;
        print(news.date);
      });
    });
  }
}
