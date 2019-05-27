import 'package:bitirme_odevi/common/app_background.dart';
import 'package:bitirme_odevi/model/meeting.dart';
import 'package:bitirme_odevi/model/university_departments.dart';
import 'package:bitirme_odevi/pages/meeting_page.dart';
import 'package:bitirme_odevi/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'meeting_card_page.dart';

class MeetingEditPage extends StatefulWidget {
  Meeting meeting;
  MeetingEditPage({Key key, this.meeting}) : super(key: key);

  @override
  _MeetingEditPageState createState() => _MeetingEditPageState();
}

class _MeetingEditPageState extends State<MeetingEditPage> {
  String note;
  String _valueDate;
  DateTime goDate;
  DatabaseHelper _databaseHelper;
  Meeting meeting;

  bool _isCurrentDepartmentNull = false;
  bool _isvalueDateNull = false;

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentDepartment;

  TextEditingController _notController;

  @override
  initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    _dropDownMenuItems = getDropDownMenuItems();
    _currentDepartment = widget.meeting.meetingDep;
    note = widget.meeting.meetingNote;
    _valueDate = widget.meeting.meetingDate;
    _notController = TextEditingController(text: widget.meeting.meetingNote);
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String department in universityDepartment) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          new DropdownMenuItem(value: department, child: new Text(department)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                  Navigator.of(context).pop();
                },
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
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: _isCurrentDepartmentNull
                                          ? Colors.red
                                          : Colors.black54),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: DropdownButton(
                                    value: _currentDepartment,
                                    items: _dropDownMenuItems,
                                    onChanged: changedDropDownItem,
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _notController,
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
                              if (_currentDepartment !=
                                      "Lütfen bir bölüm seçin" &&
                                  _valueDate != null) {
                                setState(() {
                                  widget.meeting.meetingNote = note;
                                  widget.meeting.meetingDate = goDate == null ? _valueDate : goDate.toString();
                                  widget.meeting.meetingDep =
                                      _currentDepartment;
                                });

                                await _databaseHelper
                                    .meetingUpdate(widget.meeting);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MeetingCardPage(
                                          meeting: widget.meeting,
                                        )));
                              } else {
                                setState(() {
                                  _isCurrentDepartmentNull = true;
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

  void changedDropDownItem(String selectedDepartment) {
    setState(() {
      _currentDepartment = selectedDepartment;
    });
  }

  Padding conversationTitle() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Text(
        "Toplantı Kaydı Düzenleme",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ContactPicker {}
