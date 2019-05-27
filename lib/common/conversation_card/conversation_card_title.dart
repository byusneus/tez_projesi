import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ConversationCardTitle extends StatelessWidget {
  final title;
  const ConversationCardTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Padding(
            padding: EdgeInsets.only(top:8.0),
            child: Text("Görüşme Kaydı", style: TextStyle(fontStyle: FontStyle.italic),),
          ),
          
        ],
      ),
    );
  }
}