import 'package:flutter/material.dart';
import 'package:rizhihubao/util/GetData.dart';
import 'package:rizhihubao/util/bean/News.dart';
import 'package:rizhihubao/views/NewsListView.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
  Swiper mySwiper;

  int swipIndex;

  @override
  void initState() {
    super.initState();
    getNews();
    title = "首页";
    swipIndex = 0;

    mySwiper = Swiper(
      itemBuilder: (BuildContext context, int index) {
        return new Image.network(
          news.stories[index + 5].images,
          fit: BoxFit.fill,
        );
      },
      itemCount: 5,
      viewportFraction: 1.0,
      scale: 1.0,
      autoplay: true,
      autoplayDelay: 3000,
      itemHeight: 5000,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
//        appBar: AppBar(title: Text("新闻"),actions: <Widget>[],),
        body: news == null
            ? Text("Loading")
            : NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: false,
                      flexibleSpace: Swiper(
                        pagination: DotSwiperPaginationBuilder(),
                        autoplay: true,
                        autoplayDelay: 3000,
                        itemCount: 4,
                        itemBuilder: (ctx, i) {
                          return Image.network(
                            news.stories[i].images,
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                    ),
                  ];
                },
                body: Center(
                    child: NewsListView(
                  news: news,
                )),
              ),
        drawer: Drawer(
            child: ListView(
          children: <Widget>[Text("Drawer")],
        )),
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
