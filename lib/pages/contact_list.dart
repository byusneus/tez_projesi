import 'dart:async';

import 'package:bitirme_odevi/common/app_background.dart';
import 'package:bitirme_odevi/model/contact_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactList extends StatefulWidget {
  
  bool edit;
  ContactList({Key key,  this.edit}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  Iterable<Contact> _contacts;

  @override
  void initState() {
    super.initState();
    refreshContacts();
  }

  refreshContacts() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      var contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts;
      });
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.disabled) {
      Map<PermissionGroup, PermissionStatus> permissionStatus =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.contacts]);
      return permissionStatus[PermissionGroup.contacts] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to location data denied",
          details: null);
    } else if (permissionStatus == PermissionStatus.disabled) {
      throw new PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBackground(),
          Center(
            child: _contacts == null
                ? CircularProgressIndicator()
                : _buildContactList(_contacts.toList()),
          )
        ],
      ),
    );
  }

  Container _buildContactList(List<Contact> liste) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 18.0),
        child: ListView.builder(
          itemCount: liste.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (widget.edit) {
                  Navigator.of(context).pop(liste[index].displayName);
                } else {
                  Navigator.of(context).pop(liste[index].displayName);
                }
              },
              child: Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                child: Container(
                  height: 70,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 28.0),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.3)),
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.6)),
                            child: (liste[index].avatar.length != 0)
                                ? CircleAvatar(
                                    backgroundImage:
                                        MemoryImage(liste[index].avatar))
                                : Center(
                                    child: Text(
                                        liste[index]
                                            .displayName[0]
                                            .toUpperCase(),
                                        style: TextStyle(color: Colors.black)),
                                  ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(liste[index].displayName,
                                style: TextStyle(
                                    fontSize: 16, fontStyle: FontStyle.italic)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
