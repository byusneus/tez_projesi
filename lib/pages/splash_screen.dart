import 'dart:async';

import 'package:bitirme_odevi/pages/landing_page.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  var timeout = const Duration(seconds: 3);
  var ms = const Duration(milliseconds: 1);

  startTimeout([int milliseconds]) {
    var duration = timeout;
    return new Timer(duration, handleTimeout);
  }

  

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: FlareActor(
        "assets/Trim.flr",
        animation: "Start",
        color: Colors.black,
      ),
    );
  }

  void handleTimeout() {
    setState(() {
      loading = false;
      Navigator.push(context, PageTransition(type: PageTransitionType.size, child: LandingPage(), duration: Duration(milliseconds: 500), alignment: Alignment.center));
    });
  }
}
