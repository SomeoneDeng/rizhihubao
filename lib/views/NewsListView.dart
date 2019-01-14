import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rizhihubao/util/GetData.dart';
import 'package:rizhihubao/util/bean/News.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
  Swiper mySwiper;

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

    mySwiper = Swiper(
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            print(
                "this ${news.stories[index + 4].id} of <<${news.stories[index + 4].title}>>");
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
            decoration: BoxDecoration(
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage(news.stories[index + 4].images))),
            child: Text(news.stories[index + 4].title,
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center),
            alignment: Alignment.bottomCenter,
          ),
        );
      },
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          builder: DotSwiperPaginationBuilder(
              activeColor: Colors.teal,
              color: Colors.white,
              activeSize: 8,
              size: 5)),
      itemCount: 5,
      viewportFraction: 1.0,
      scale: 1.0,
      autoplay: true,
      autoplayDelay: 5000,
      itemHeight: 5000,
    );
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
        children: <Widget>[
              Container(
                child: mySwiper,
                height: 160,
              )
            ] +
            List.from(news.stories.map((i) => NewsListViewItem(
                  story: i,
                ))),
      ),
    );
  }

  /// 上划拉取更多
  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      var nowdate = DateTime.parse(news.date);
      var lastday = nowdate.add(Duration(days: -1));
      GetData().getNewsBefore(formatDate(lastday, [yyyy, mm, dd])).then((n) {
        setState(() {
          news.stories.add(Story(dateType: true, title: n.date));
          news.stories.addAll(n.stories);
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
        print("id: ${story.id} of 《${story.title}》");
      },
      child: story.dateType
          ? Container(
        alignment: Alignment.center,
              child: Text(formatDate(
                  DateTime.parse(story.title), [yyyy, '年', mm, '月', dd, '日'])),
            )
          : Card(
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
                  Stack(
                    children: <Widget>[
                      Image.network(
                          "https://someonedeng-1253259777.cos.ap-guangzhou.myqcloud.com/blog/image/loading.gif",
                        height: 10,
                        width: 10,
                      ),
                      Image.network(
                        story.images,
                        scale: 2,
                      )
                    ],
                  )
                ],
              ),
            )),
    );
  }
}
