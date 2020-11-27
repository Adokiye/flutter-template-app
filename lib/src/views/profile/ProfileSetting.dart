import 'package:Instahelp/modules/setting/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Instahelp/components/headerText.dart';
import 'package:Instahelp/components/subText.dart';
import 'package:Instahelp/helpers/sizeCalculator.dart';
import 'package:Instahelp/components/buttonBlue.dart';
import 'package:Instahelp/components/backButtonWhite.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:dio/dio.dart';
import 'package:Instahelp/modules/state/AppState.dart';
import 'package:Instahelp/src/entity/User.dart';

class ProfileSetting extends StatefulWidget {
  ProfileSetting({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProfileSettingState createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  bool loading = false;
  User user;
  @override
  void initState() {
    super.initState();
    setState((){
      user = AppState().user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoadingOverlay(
          child:SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: new SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.only(
                      top: sizer(false, 77, context), left: sizer(true,25,context), right: sizer(true,25,context)),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            BackButtonWhite(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: sizer(false,15,context)),
                        HeaderText(title: 'Health Profile'),
                        SizedBox(height: 19),
                        dataBox('Name', user != null &&user.name!= null? user.name: ''),
                        dataBox('Phone Number', user != null && user.phoneNumber != null ?user.phoneNumber: ''),
                        dataBox('Email', user != null && user.email != null ? user.email : ''),
                        SizedBox(height: 29),
                        Container(
                          height: 1.0,
                          color: Color.fromRGBO(142, 145, 156, 0.24)
                        ),
                        SizedBox(height: 39),
                            SubText(title: 'Social Media Details', isCenter: false),
                        SizedBox(height: 24),
                        dataBox('Instagram', user.instagram= null ? user.instagram: ''),
                        dataBox('Facebook', user.facebook != null ?user.facebook:''),
                      ]),
                )))),
                isLoading: loading));
  }

  Widget dataBox(String title, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Text(title, style: TextStyle(color: GoloColors.primary, fontSize: sizer(true,14,context))),
      SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.max,
        children:<Widget>[
 Container(
          margin: EdgeInsets.only(bottom: sizer(false,10,context)),
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width-50,
          decoration: BoxDecoration(
            color: Color(0xffF3F4F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(data != '' ? data: 'N/A',
              style: TextStyle(color: data != '' ?
              GoloColors.secondary1:
              Color(0xff828282), 
              fontSize: sizer(true,16.0,context))))
        ]
      )
    
    ]);
  }
}
