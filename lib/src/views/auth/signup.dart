import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:Instahelp/components/headerText.dart';
import 'package:Instahelp/helpers/sizeCalculator.dart';
import 'components/registerSuccess.dart';
import 'components/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key,  }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> registerFn(body) async {
    setState(() {
      _loading = true;
    });
    String _baseUrl = "https://nsta-hlp.com/api/register";
    var responseJson;
    Response response;
    Dio dio = new Dio();
     print(body);
    response = await dio
        .post(
      _baseUrl,
      data: body,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {
            "Content-Type": "application/json",
            "Connection": 'keep-alive'
          }),
    )
        .catchError((e) {
      setState(() {
        _loading = false;
      });
      print(e.response.data);
      var message = '';
      if (e.response.data['detail'] != null) {
        message = e.response.data['detail'];
      } else {
        message =
            e.response.data.toString().substring(1, e.response.data.length - 1);
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true,15.0,context),
              color: Colors.white,
              //   fontWeight: FontWeight.w300,
            )),
        // duration: Duration(seconds: 3),
      ));
    });
    setState(() {
      _loading = false;
    });
    responseJson = response.data;
    if (response.statusCode != 200) {
      print(response.statusCode);
      var message = '';
      if (response.data['email'] != null) {
        message = response.data['email']
            .toString()
            .substring(1, response.data['email'].toString().length - 1);
      } else {
        message = response.data.toString();
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true,15.0,context),
              color: Colors.white,
              //   fontWeight: FontWeight.w300,
            )),
        // duration: Duration(seconds: 3),
      ));
    }else{
    return Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => RegisterSuccess(
          )),
    );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SignUpBody(
          loading: _loading,
          registerFn: registerFn,
        ));
  }
}
