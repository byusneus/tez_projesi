
import 'package:bitirme_odevi/pages/conversation_page.dart';
import 'package:bitirme_odevi/pages/meeting_page.dart';
import 'package:bitirme_odevi/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LandingPageButtons extends StatelessWidget {
  const LandingPageButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
                Navigator.push(context, PageTransition(type: PageTransitionType.size, child: ConversationPage(), duration: Duration(milliseconds: 500), alignment: Alignment.center));
          },
          child: Container(
            width: 75,
            height: 75,
            decoration:
                BoxDecoration(color: Colors.green, shape: BoxShape.circle),
            child: Icon(
              Icons.call,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MeetingPage()));
          },
          child: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
                color: Colors.orangeAccent, shape: BoxShape.circle),
            child: Icon(
              Icons.markunread_mailbox,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        InkWell(
          onTap: () {
                 Navigator.push(context, PageTransition(type: PageTransitionType.size, child: SearchPage(), duration: Duration(milliseconds: 500), alignment: Alignment.center));
          },
          child: Container(
            width: 75,
            height: 75,
            decoration:
                BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            child: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
