import 'package:bitirme_odevi/model/conversation.dart';
import 'package:bitirme_odevi/pages/conversation_card_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ConversationCard extends StatelessWidget {
  final Conversation conversation;
  ConversationCard({Key key, this.conversation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
            Navigator.push(context, PageTransition(type: PageTransitionType.downToUp, child: ConversationCardPage(conversation: conversation), duration: Duration(milliseconds: 250), alignment: Alignment.center));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        child: Container(
          height: 70,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 28.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.3)),
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.6)),
                    child: Center(
                      child: Text(conversation.conversationUser[0].toUpperCase()+conversation.conversationUser[1].toUpperCase())
                    )
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(conversation.conversationUser,
                        style: TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
