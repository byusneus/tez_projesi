import 'package:flutter/material.dart';

class MeetingDetailsTitle extends StatelessWidget {
  final width;
  const MeetingDetailsTitle({Key key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Center(
        child: Text(
          "Toplantılar",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
        ),
      ),
    );
  }
}