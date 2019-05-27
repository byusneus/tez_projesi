import 'package:bitirme_odevi/model/contact_service.dart';
import 'package:bitirme_odevi/model/conversation.dart';
import 'package:bitirme_odevi/pages/conversation_edit_page.dart';
import 'package:bitirme_odevi/pages/conversation_page.dart';
import 'package:bitirme_odevi/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';

class ConversationCardDetails extends StatefulWidget {
  Conversation conversation;
  ConversationCardDetails({Key key, this.conversation}) : super(key: key);

  @override
  _ConversationCardDetailsState createState() => _ConversationCardDetailsState();
}

class _ConversationCardDetailsState extends State<ConversationCardDetails> {

  DatabaseHelper _databaseHelper;
  DateTime conversationDate;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    getStringDate();
  }

  getStringDate(){
    setState(() {
     conversationDate = DateTime.parse(widget.conversation.conversationDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Görüşme Notu",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Container(width: double.infinity, height: 1, color: Colors.grey),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
               widget.conversation.conversationNote == null ? "Bu kayda not eklenmemiştir!" : widget.conversation.conversationNote ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text(
                "Tarih :       ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(conversationDate.day.toString()+ "-"+conversationDate.month.toString()+ "-" + conversationDate.year.toString(), style: TextStyle()),
            ],
          ),
        ),
        SizedBox(
          height: 100,
        ),
        _buildButtons(context),
      ],
    );
  }

  Row _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(context, PageTransition(type: PageTransitionType.downToUp, child: ConversationEditPage(conversation: widget.conversation,), duration: Duration(milliseconds: 500), alignment: Alignment.center));
          },
          child: Container(
            width: 100,
            height: 50,
            child: Material(
              borderRadius: BorderRadius.circular(20),
              shadowColor: Colors.greenAccent,
              color: Colors.green,
              elevation: 10,
              child: Center(
                child: Text("Düzenle",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _showDialog(context);
          },
          child: Container(
            width: 100,
            height: 50,
            child: Material(
              borderRadius: BorderRadius.circular(20),
              shadowColor: Colors.redAccent,
              color: Colors.redAccent,
              elevation: 10,
              child: Center(
                child: Text("Sil",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text('Bu kayıt silinsin mi?'),
          content: const Text(
              'Bu işlem gerçekleştikten sonra kayda tekrar erişim sağlanamayacak.'),
          actions: <Widget>[
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              color: Colors.blueAccent,
              child: const Text(
                'İptal',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              color: Colors.red,
              child: const Text(
                'Sil',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _databaseHelper.conversationDelete(widget.conversation.conversationID);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ConversationPage()));
              },
            )
          ],
        );
      },
    );
  }
}
