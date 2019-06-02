import 'package:bitirme_odevi/pages/conversation_page.dart';
import 'package:bitirme_odevi/pages/meeting_page.dart';
import 'package:bitirme_odevi/pages/search_page.dart';
import 'package:flutter/material.dart';

import 'custom_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.deepOrange, Colors.orangeAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/logoapp.png"),
                        fit: BoxFit.contain),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Kayıt Defteri"),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CustomListTile(
            icon: Icon(Icons.call, color: Colors.grey.shade800,),
            subtitle: "Görüşmeler",
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConversationPage())),
          ),
          CustomListTile(
            icon: Icon(Icons.markunread_mailbox, color: Colors.grey.shade800,),
            subtitle: "Toplantılar",
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => MeetingPage())),
          ),
          CustomListTile(
            icon: Icon(Icons.search, color: Colors.grey.shade800,),
            subtitle: "Sorgu",
           onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage())),
          ),
        ],
      ),
    );
  }
}
