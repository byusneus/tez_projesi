import 'package:bitirme_odevi/common/meeting/meeting_details_list.dart';
import 'package:bitirme_odevi/common/meeting/meeting_details_title.dart';
import 'package:bitirme_odevi/model/meeting.dart';
import 'package:bitirme_odevi/pages/meeting_create_page.dart';
import 'package:flutter/material.dart';

class MeetingDetails extends StatelessWidget {
  List<Meeting> toplantilar;
  MeetingDetails({Key key, this.toplantilar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final width = constraint.maxWidth;
        final height = constraint.maxHeight;

        return Column(
          children: <Widget>[
            SizedBox(
              height: width / 6,
            ),
            MeetingDetailsTitle(
              width: width,
            ),
            SizedBox(
              height: width / 10,
            ),
            _buildButton(context),
            MeetingDetailsList(
              toplantilar: toplantilar,
              height: height,
            ),
          ],
        );
      },
    );
  }

  Container _buildButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(right: 18.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MeetingCreatePage()));
            },
            child: Container(
              width: 75,
              height: 30,
              child: Material(
                borderRadius: BorderRadius.circular(20),
                shadowColor: Colors.greenAccent,
                color: Colors.green,
                elevation: 10,
                child: Center(
                  child: Text("Yeni Kayıt",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
