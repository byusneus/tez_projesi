import 'package:bitirme_odevi/common/app_background.dart';
import 'package:bitirme_odevi/common/landing_page_buttons.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Future.value(
              false); //return a `Future` with false value so this route cant be popped or closed.
        },
        child: Stack(
          children: <Widget>[
            AppBackground(),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 500,
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Image.asset("assets/logoapp.png"),
                      ),
                    ),
                  ),
                ),
                LandingPageButtons()
              ],
            )
          ],
        ),
      ),
    );
  }
}
