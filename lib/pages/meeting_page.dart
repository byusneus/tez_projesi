import 'package:bitirme_odevi/common/app_background.dart';
import 'package:bitirme_odevi/common/meeting/meeting_details.dart';
import 'package:bitirme_odevi/model/meeting.dart';
import 'package:bitirme_odevi/pages/landing_page.dart';
import 'package:bitirme_odevi/utils/database_helper.dart';
import 'package:flutter/material.dart';

class MeetingPage extends StatefulWidget {
  const MeetingPage({Key key}) : super(key: key);

  @override
  _MeetingPageState createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {

  DatabaseHelper _databaseHelper;
  List<Meeting> toplantilar;

  @override
  void initState() {
    super.initState();
    toplantilar = List<Meeting>();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.meetingRead().then((meetingMapList){
      for (Map meetingMap in meetingMapList) {
        toplantilar.add(Meeting.fromMap(meetingMap));
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Future.value(
              false); //return a `Future` with false value so this route cant be popped or closed.
        },
        child: Stack(
          children: <Widget>[
            AppBackground(),
            _buildArrowBack(context),
            MeetingDetails(toplantilar: toplantilar)
          ],
        ),
      ),
    );
  }

  Padding _buildArrowBack(BuildContext context) {
    return Padding(
            padding: EdgeInsets.only(top: 60.0, left: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LandingPage()));
                },
              ),
            ),
          );
  }
}
