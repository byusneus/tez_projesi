import 'package:bitirme_odevi/common/app_background.dart';
import 'package:bitirme_odevi/common/drawer.dart';
import 'package:bitirme_odevi/common/meeting_card/meeting_card_details.dart';
import 'package:bitirme_odevi/common/meeting_card/meeting_card_title.dart';
import 'package:bitirme_odevi/model/meeting.dart';
import 'package:flutter/material.dart';

class MeetingCardPage extends StatelessWidget {
  final Meeting meeting;
  final _key = GlobalKey<ScaffoldState>();
  MeetingCardPage({Key key, this.meeting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _key,
      drawer: MyDrawer(),
      body: Stack(
        children: <Widget>[
          AppBackground(),
          Padding(
            padding: EdgeInsets.only(top: 30.0, left: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0, right: 15),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () => _key.currentState.openDrawer(),
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: MediaQuery.of(context).size.height - 150,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    MeetingCardTitle(title: meeting.meetingDep),
                    SizedBox(
                      height: 100,
                    ),
                    MeetingCardDetails(meeting: meeting),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
