import 'dart:async';

import 'package:bitirme_odevi/common/conversation/conversation_card.dart';
import 'package:bitirme_odevi/model/conversation.dart';
import 'package:flutter/material.dart';

class ConversationDetailsList extends StatefulWidget {
  List<Conversation> gorusmeler;
  final height;
  ConversationDetailsList({Key key, this.height, this.gorusmeler}) : super(key: key);

  @override
  _ConversationDetailsListState createState() => _ConversationDetailsListState();
}

class _ConversationDetailsListState extends State<ConversationDetailsList> {

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
      child: loading ? Center(child: CircularProgressIndicator(),) : (widget.gorusmeler.length == 0 ? Center(child: Text("Görüşme kaydı yok!"),) : _buildConversationList())
    );
  }

  ListView _buildConversationList() {
    return ListView.builder(
      itemCount: widget.gorusmeler.length,
      itemBuilder: (context, index){
        return ConversationCard(conversation: widget.gorusmeler[index]);
      },
    );
  }
}