import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint){
        final height = constraint.maxHeight;
        final width = constraint.maxWidth;

        return Stack(
          children: <Widget>[
            Container(
              color: Colors.grey.shade300,
            ),
            Positioned(
              left: -(height/2 - width/3),
              bottom: height*0.2,
              child: Container(
                height: height,
                width: width*2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            Positioned(
              left: -(height - width*0.85),
              top: -width*0.8,
              child: Container(
                height: height,
                width: width*2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade100,
                ),
              ),
            ),
            Positioned(
              left: -(height/2 - width/2),
              top: -160,
              child: Container(
                height: height*0.6,
                width: width*0.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
            
          ],
        );
      },
    );
  }
}