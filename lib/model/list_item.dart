import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  String title, date, color, time;
  ListItem({this.title,this.date,this.time,this.color});
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0,horizontal: 8.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new CircleAvatar(
              child: new Text(title!=null?title.substring(0,1):"T",style: new TextStyle(fontSize: 30.0),),
              radius: 30.0,
            ),
            new Padding(padding: new EdgeInsets.only(right: 10.0)),
            new Expanded(
              child: new Container(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      title??"Title Not Available",
                      style: new TextStyle(fontSize: 20.0),
                      softWrap: true,
                    ),
                    new Divider(),
                    new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Text("Date : ${date??"NA"}"),
                        ),
                        new Expanded(
                          child: new Text("Time : ${time??"NA"}"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
