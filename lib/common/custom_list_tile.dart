import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final icon;
  final subtitle;
  final onTap;
  CustomListTile({Key key, this.icon, this.subtitle, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.orangeAccent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  icon,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_right, color: Colors.grey.shade900,),
            ],
          ),
        ),
      ),
    );
  }
}
