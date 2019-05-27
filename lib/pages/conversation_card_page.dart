import 'package:bitirme_odevi/common/app_background.dart';
import 'package:bitirme_odevi/common/conversation_card/conversation_card_details.dart';
import 'package:bitirme_odevi/common/conversation_card/conversation_card_title.dart';
import 'package:bitirme_odevi/model/contact_service.dart';
import 'package:bitirme_odevi/model/conversation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class ConversationCardPage extends StatefulWidget {
  Conversation conversation;
  ConversationCardPage({Key key, this.conversation}) : super(key: key);

  @override
  _ConversationCardPageState createState() => _ConversationCardPageState();
}

class _ConversationCardPageState extends State<ConversationCardPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                    ConversationCardTitle(title: widget.conversation.conversationUser),
                    SizedBox(
                      height: 100,
                    ),
                    ConversationCardDetails(conversation: widget.conversation),
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
