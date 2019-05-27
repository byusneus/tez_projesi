import 'package:bitirme_odevi/common/app_background.dart';
import 'package:bitirme_odevi/model/conversation.dart';
import 'package:bitirme_odevi/model/meeting.dart';
import 'package:bitirme_odevi/pages/conversation_card_page.dart';
import 'package:bitirme_odevi/pages/landing_page.dart';
import 'package:bitirme_odevi/pages/meeting_card_page.dart';
import 'package:bitirme_odevi/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Conversation> gorusmeler;
  List<Meeting> toplantilar;

  List<Conversation> listelenecekGorusmeler;
  List<Meeting> listelenecekToplantilar;

  DateTime _firstSearchDate;
  DateTime _secondSearchDate;

  String _valueDate;
  String _secondvalueDate;
  bool _isvalueDateNull = false;
  bool _issecondvalueDateNull = false;

  DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _secondSearchDate = DateTime.now();
    _firstSearchDate= DateTime.utc(_secondSearchDate.year, _secondSearchDate.month-1, _secondSearchDate.day);
    gorusmeler = List<Conversation>();
    toplantilar = List<Meeting>();
    listelenecekGorusmeler = List<Conversation>();
    listelenecekToplantilar = List<Meeting>();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.conversationRead().then((gorusmeMapList) {
      for (Map gorusmeMap in gorusmeMapList) {
        gorusmeler.add(Conversation.fromMap(gorusmeMap));
      }
      setState(() {});
    });
    _databaseHelper.meetingRead().then((toplantiMapList) {
      for (Map toplantiMap in toplantiMapList) {
        toplantilar.add(Meeting.fromMap(toplantiMap));
      }
      setState(() {});
    });
    getDates();
  }

  void getDates() {
    var date = new DateTime.now();
    var now = DateTime.utc(date.year, date.month - 1, date.day);
    var thirtyDaysFromNow = date;

    setState(() {
      _valueDate = now.year.toString() +
          "-" +
          now.month.toString() +
          "-" +
          now.day.toString();
      _secondvalueDate = thirtyDaysFromNow.year.toString() +
          "-" +
          thirtyDaysFromNow.month.toString() +
          "-" +
          thirtyDaysFromNow.day.toString();
    });
  }


  void fillConversationList() {
    setState(() {
      listelenecekGorusmeler= List<Conversation>();
    });

    for (Conversation gorusme in gorusmeler) {
      var gorusmeDate = DateTime.parse(gorusme.conversationDate);
      var firstDiff = gorusmeDate.difference(_firstSearchDate);
      var secondDiff = gorusmeDate.difference(_secondSearchDate);
      if(firstDiff.isNegative == false && secondDiff.isNegative == true){
        listelenecekGorusmeler.add(gorusme);
        setState(() {});
      }
    }
  }

  void fillMeetingList() {
    setState(() {
      listelenecekToplantilar= List<Meeting>();
    });

    for (Meeting toplanti in toplantilar) {
      var toplantiDate = DateTime.parse(toplanti.meetingDate);
      var firstDiff = toplantiDate.difference(_firstSearchDate);
      var secondDiff = toplantiDate.difference(_secondSearchDate);
      if(firstDiff.isNegative == false && secondDiff.isNegative == true){
        listelenecekToplantilar.add(toplanti);
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBackground(),
          Padding(
            padding: EdgeInsets.only(top: 60.0),
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
          ),
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                _buildSearch(context),
                SizedBox(
                  height: 65,
                ),
                Container(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Görüşmeler",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listelenecekGorusmeler.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ConversationCardPage(
                                    conversation: listelenecekGorusmeler[index],
                                  )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 10,
                            child: Container(
                              width: MediaQuery.of(context).size.width-50,
                              height: 75,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey),
                                    child: Center(
                                      child: Text(listelenecekGorusmeler[index]
                                          .conversationUser[0]
                                          .toUpperCase()),
                                    ),
                                  ),
                                  Text(listelenecekGorusmeler[index].conversationUser)
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Toplantılar",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listelenecekToplantilar.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MeetingCardPage(
                                    meeting: listelenecekToplantilar[index],
                                  )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 10,
                            child: Container(
                              width: MediaQuery.of(context).size.width-50,
                              height: 75,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey),
                                    child: Center(
                                      child: Text(listelenecekToplantilar[index]
                                          .meetingDep[0]
                                          .toUpperCase()),
                                    ),
                                  ),
                                  Text(listelenecekToplantilar[index].meetingDep)
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _buildSearch(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2018, 1, 1),
                  maxTime: DateTime(2019, 12, 31),
                  onChanged: (date) {}, onConfirm: (date) {
                setState(() {
                  _valueDate = date.year.toString() +
                      "-" +
                      date.month.toString() +
                      "-" +
                      date.day.toString();
                  _firstSearchDate = date;
                });
              }, currentTime: DateTime.now(), locale: LocaleType.tr);
            },
            child: Container(
              width: 110,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(
                    color: _isvalueDateNull ? Colors.red : Colors.black54),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      _valueDate == null ? "Tarih" : _valueDate,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: InkWell(
              onTap: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2018, 3, 5),
                    maxTime: DateTime(2019, 6, 7),
                    onChanged: (date) {}, onConfirm: (date) {
                  setState(() {
                    _secondvalueDate = date.year.toString() +
                        "-" +
                        date.month.toString() +
                        "-" +
                        date.day.toString();
                    _secondSearchDate = date;
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.tr);
              },
              child: Container(
                width: 110,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(
                      color: _isvalueDateNull ? Colors.red : Colors.black54),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        _secondvalueDate == null ? "Tarih" : _secondvalueDate,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      fillConversationList();
                      fillMeetingList();
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
