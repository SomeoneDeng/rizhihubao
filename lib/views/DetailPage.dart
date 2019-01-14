import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:rizhihubao/util/GetData.dart';
import 'package:rizhihubao/util/bean/News.dart';

class StoryDetailPage extends StatefulWidget {
  String id;

  StoryDetailPage(this.id);

  @override
  State<StatefulWidget> createState() {
    return _StoryDetailState(id);
  }
}

class _StoryDetailState extends State<StoryDetailPage> {
  String id;
  StoryDetail storyDetail;

  _StoryDetailState(this.id);

  @override
  void initState() {
    super.initState();
    GetData().getNewsDetail(id).then((sd) {
      setState(() {
        this.storyDetail = sd;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share,color: Colors.white,), onPressed: () {},),
          IconButton(icon: Icon(Icons.star,color: Colors.white,), onPressed: () {},),
          IconButton(icon: Icon(Icons.message,color: Colors.white,), onPressed: () {},),
          IconButton(icon: Icon(Icons.thumb_up,color: Colors.white,), onPressed: () {},),
        ],
      ),
      body: storyDetail == null
          ? Center(
              child: Text("loading.."),
            )
          : ListView(
              children: <Widget>[
                Container(
                  child: ListTile(
                    title: Text(
                      storyDetail.title,
                      style: TextStyle(color: Colors.white, shadows: [
                        Shadow(
                            color: Colors.black45,
                            offset: Offset(1, 1),
                            blurRadius: 0)
                      ]),
                    ),
                    subtitle: Text(
                      storyDetail.imageSource,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.white30,
                          shadows: [
                            Shadow(
                                color: Colors.black45,
                                offset: Offset(1, 1),
                                blurRadius: 0)
                          ],
                          fontSize: 10),
                    ),
                  ),
                  height: 160,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(storyDetail.image))),
                ),
              ],
            ),
    );
  }
}
