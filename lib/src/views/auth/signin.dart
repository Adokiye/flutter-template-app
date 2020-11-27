import 'dart:convert';

import 'package:Instahelp/modules/state/AppState.dart';
import 'package:Instahelp/src/views/main/DashboardTabs.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'components/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:Instahelp/src/entity/User.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> loginFn(body) async {
    setState(() {
      _loading = true;
    });
    String _baseUrl = "https://nsta-hlp.com/api/app/users/login";
    var responseJson;
    Response response;
    Dio dio = new Dio();

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
        message = e.response.data.toString();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
            )),
      ));
    });
    // setState(() {
    //   _loading = false;
    // });
    responseJson = response.data;
    print('----');
    print(responseJson['data']['access_token']);
    print('----');

    if (response.statusCode != 200) {
      print('sksksk');
      var message = '';
        message = response.data.toString();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              //   fontWeight: FontWeight.w300,
            )),
        // duration: Duration(seconds: 3),
      ));
    }else{

    print(responseJson);
    if(responseJson['data']['access_token'] == null){
     
    }else{
    return getUser(responseJson['data']['access_token']);
    }

    }

  }

    Future<dynamic> getUser(token) async {
    String _baseUrl = "https://nsta-hlp.com/api/app/users";
    var responseJson;
    Response response;
    Dio dio = new Dio();

    response = await dio
        .get(
      _baseUrl,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {
            "Authorization": "Bearer " + token,
            "Connection": 'keep-alive'
          }),
    )
        .catchError((e) {
      setState(() {
        _loading = false;
      });
      print(e.response.data);
      var message = '';
        message = e.response.data.toString();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
            )),
      ));
    });
    setState(() {
      _loading = false;
    });
    responseJson = response.data;

    if (response.statusCode != 200) {
      print('sksksk');
      var message = '';
        message = response.data.toString();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              //   fontWeight: FontWeight.w300,
            )),
        // duration: Duration(seconds: 3),
      ));
    }else{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('user', json.encode(responseJson));
    AppState().user = User.fromJson(responseJson);
    AppState().token = token;
    return Navigator.of(context)
    .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => DashboardTabs()));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SignInBody(
          loading: _loading,
          loginFn: loginFn,
        ));
  }
}
