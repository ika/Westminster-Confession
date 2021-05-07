
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'dbHelper.dart';
import 'dbModel.dart';
import 'xDetailPage.dart';

// The Larger Catachism

class XMain extends StatefulWidget {
  @override
  _XMainState createState() => _XMainState();
}

class _XMainState extends State<XMain> {
  DBProvider dbProvider = DBProvider();
  List<Chapter> chapters = List<Chapter>.empty();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<Chapter>>(
        future: dbProvider.getTitleList('etexts'),
        builder: (context, AsyncSnapshot<List<Chapter>> snapshot) {
          if (snapshot.hasData) {
            chapters = snapshot.data;
            return showChapterList(chapters, context);
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  showChapterList(List<Chapter> chapters, context) {
    ListTile makeListTile(chapters, int index) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        // leading: Container(
        //   padding: EdgeInsets.only(right: 12.0),
        //   decoration: new BoxDecoration(
        //       border: new Border(
        //           right: new BorderSide(width: 1.0, color: Colors.white24))),
        //   child: Icon(Icons.autorenew, color: Colors.white),
        // ),
        title: Text(
          chapters[index].chap,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Flexible(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                strutStyle: StrutStyle(fontSize: 12.0),
                text: TextSpan(
                    style: TextStyle(color: Colors.white),
                    text: " " + chapters[index].title),
              ),
            ),
          ],
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
        onTap: () {
          Future.delayed(const Duration(milliseconds: 200), () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) =>
                        XDetailPage(index)));
          });
        });

    Card makeCard(chapters, int index) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(chapters, index),
          ),
        );

    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: chapters == null ? 0 : chapters.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(chapters, index);
        },
      ),
    );

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(64, 75, 96, .9),
      title: Text('Larger Catechism'),
      // actions: <Widget>[
      //  IconButton(
      //    icon: Icon(Icons.list_sharp),
      //    onPressed: () {},
      //  )
      // ],
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
    );
  }
}
