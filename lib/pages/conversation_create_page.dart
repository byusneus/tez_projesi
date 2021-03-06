import 'package:bitirme_odevi/common/app_background.dart';
import 'package:bitirme_odevi/common/drawer.dart';
import 'package:bitirme_odevi/model/conversation.dart';
import 'package:bitirme_odevi/pages/conversation_page.dart';
import 'package:bitirme_odevi/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'contact_list.dart';

class ConversationCreatePage extends StatefulWidget {
  ConversationCreatePage({Key key}) : super(key: key);

  @override
  _ConversationCreatePageState createState() => _ConversationCreatePageState();
}

class _ConversationCreatePageState extends State<ConversationCreatePage> {

  String conversationUser;
  String note;
  String _valueDate;
  DateTime goDate;
  DatabaseHelper _databaseHelper;
  Conversation conversation;

  final _key = GlobalKey<ScaffoldState>();
  

  bool _isUserNull = false;
  bool _isvalueDateNull = false;

  @override
  initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    
  }

  
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
            padding: EdgeInsets.only(top: 60.0, left: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ConversationPage()));
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 60.0, right: 15),
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
          Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              conversationTitle(),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: MediaQuery.of(context).size.height - 150,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) => ContactList(
                                          edit: false,
                                        ),
                                  ),
                                )
                                    .then((user) {
                                  setState(() {
                                    conversationUser = user;
                                  });
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                height: 70,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: _isUserNull
                                          ? Colors.red
                                          : Colors.black54),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        conversationUser == null
                                            ? "Görüşülen Kişi"
                                            : conversationUser,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (e) {
                                setState(() {
                                  note = e;
                                });
                              },
                              maxLines: 5,
                              maxLength: 100,
                              decoration: InputDecoration(
                                labelText: "Not",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2018, 3, 5),
                                    maxTime: DateTime(2019, 6, 7),
                                    onChanged: (date) {}, onConfirm: (date) {
                                  setState(() {
                                    _valueDate = date.year.toString() +
                                        "-" +
                                        date.month.toString() +
                                        "-" +
                                        date.day.toString();

                                    goDate = date;
                                  });
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.tr);
                              },
                              child: Container(
                                width: double.infinity,
                                height: 70,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: _isvalueDateNull
                                          ? Colors.red
                                          : Colors.black54),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Tarih : ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        _valueDate == null ? " " : _valueDate,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          InkWell(
                            onTap: () async {
                              if (conversationUser != null && _valueDate != null) {
                                await _databaseHelper.conversationCreate(
                                    Conversation(
                                        conversationUser, note, goDate.toString()));

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ConversationPage()));
                              } else {
                                setState(() {
                                  _isUserNull = true;
                                  _isvalueDateNull = true;
                                });
                              }
                            },
                            child: Container(
                              width: 100,
                              height: 50,
                              child: Material(
                                borderRadius: BorderRadius.circular(20),
                                shadowColor: Colors.greenAccent,
                                color: Colors.greenAccent,
                                elevation: 10,
                                child: Center(
                                  child: Text("Kaydet",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding conversationTitle() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Text(
        "Yeni Kayıt",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ContactPicker {}
