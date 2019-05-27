import 'dart:async';

import 'package:bitirme_odevi/model/meeting.dart';
import 'package:flutter/material.dart';

import 'meeting_card.dart';

class MeetingDetailsList extends StatefulWidget {
  List<Meeting> toplantilar;
  final height;
  MeetingDetailsList({Key key, this.height, this.toplantilar}) : super(key: key);

  @override
  _MeetingDetailsListState createState() => _MeetingDetailsListState();
}

class _MeetingDetailsListState extends State<MeetingDetailsList> {

  bool loading = true;

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  var timeout = const Duration(seconds: 1);
  var ms = const Duration(milliseconds: 1);

  startTimeout([int milliseconds]) {
    var duration = timeout;
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    setState(() {
      loading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height*0.75,
      child: loading ? Center(child: CircularProgressIndicator(),) : (widget.toplantilar.length == 0 ? Center(child: Text("Toplantı kaydı yok!"),) : _buildMeetingList())
    );
  }

  ListView _buildMeetingList() {
    return ListView.builder(
      itemCount: widget.toplantilar.length,
      itemBuilder: (context, index){
        return MeetingCard(meeting: widget.toplantilar[index],);
      },
    );
  }
}