import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:native_web_view/native_web_view.dart';
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
//        appBar:
        body: storyDetail == null
            ? Center(
                child: Card()
              )
            : Stack(
                children: <Widget>[

                  Container(
//                      height: 5000,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: WebView(
                        initialUrl: """<html>
                          <head>
                          <title>${storyDetail.title}</title>
                          <link rel="stylesheet" type="text/css" href="${storyDetail.css[0]}">
                          </head>
                          <body>
                            ${storyDetail.body}
                          </body>
                          <script src="${storyDetail.js[0]}"></script>
                          </html>
                         """,
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated:
                            (WebViewController webViewController) {
                          ((WebViewController e) {
                            print("loading html.....");
//                      e.loadHtmlString();
                          })(webViewController);
                        },
                      ),
                    ),
                  Container(
                    child: ListTile(
                      title: Text(
                        storyDetail.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            shadows: [
                              Shadow(color: Colors.black45, blurRadius: 1)
                            ]),
                      ),
                      subtitle: Text(
                        storyDetail.imageSource,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white70, shadows: [
                          Shadow(color: Colors.black45, blurRadius: 1)
                        ]),
                      ),
                    ),
                    decoration: BoxDecoration(
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(storyDetail.image))),
                    height: 200,
                    alignment: Alignment.bottomCenter,
                  ),
                ],
              ));
  }
}
