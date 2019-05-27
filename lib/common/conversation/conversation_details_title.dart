import 'package:flutter/material.dart';

class ConversationDetailsTitle extends StatelessWidget {
  final width;
  const ConversationDetailsTitle({Key key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Center(
        child: Text(
          "Görüşmeler",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
        ),
      ),
    );
  }
}