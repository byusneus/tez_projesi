import 'package:bitirme_odevi/common/app_background.dart';
import 'package:bitirme_odevi/common/conversation/conservation_details.dart';
import 'package:bitirme_odevi/model/conversation.dart';
import 'package:bitirme_odevi/pages/landing_page.dart';
import 'package:bitirme_odevi/utils/database_helper.dart';
import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({Key key}) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  DatabaseHelper _databaseHelper;
  List<Conversation> gorusmeler;

  @override
  void initState() {
    super.initState();
    gorusmeler = List<Conversation>();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.conversationRead().then((conversationMapList){
      for (Map conversationMap in conversationMapList) {
        gorusmeler.add(Conversation.fromMap(conversationMap));
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
            ConversationDetails(gorusmeler: gorusmeler),
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
