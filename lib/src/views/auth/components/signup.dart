import 'package:Instahelp/modules/setting/colors.dart';
import 'package:Instahelp/src/views/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:Instahelp/components/headerText.dart';
import 'package:Instahelp/components/authTextInput.dart';
import 'package:Instahelp/components/authPasswordInput.dart';
import 'package:Instahelp/components/authEmailInput.dart';
import 'package:Instahelp/components/authPhoneInput.dart';
import 'package:Instahelp/helpers/sizeCalculator.dart';
import 'package:Instahelp/components/buttonBlue.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpBody extends StatefulWidget {
  SignUpBody({Key key, this.title, this.registerFn, this.loading,})
      : super(key: key);
  final String title;
  final Function registerFn;
  final bool loading;

  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String fullName;
  String email;
  String password;
  String passwordConfirm;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void preRegister() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to our variables
      _formKey.currentState.save();
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email)) {
            print('dd');
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Invalid email',
              style: TextStyle(
                fontSize: sizer(true,15.0,context),
                color: Colors.white,
                //   fontWeight: FontWeight.w300,
              )),
          // duration: Duration(seconds: 3),
        ));
      }else if(password != passwordConfirm){
       _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Password and confirm password fields must be equal',
              style: TextStyle(
                fontSize: sizer(true,15.0,context),
                color: Colors.white,
                //   fontWeight: FontWeight.w300,
              )),
          // duration: Duration(seconds: 3),
        ));
      } else {
        Map<String, dynamic> body = {
          'email': email,
          'password': password,
          'name': fullName,
          'password_confirmation': passwordConfirm
        };
        widget.registerFn(body);
      }
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: LoadingOverlay(
          color: GoloColors.primary,
          child: SafeArea(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: new SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: sizer(false, 100, context),
                              left: sizer(true,25,context),
                              right: sizer(true,25,context)),
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                   Opacity(
                               opacity:0,
                               child:Image.asset(
                                'assets/app/launch/logo.png',
                                width: 28,
                                height: 28,
                                fit: BoxFit.contain,
                              ),
                             ), 
                                    Material(
                                        color: Color(0xffE7EEFF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          // side: BorderSide(color: Colors.red)
                                        ),
                                        child: InkWell(
                                          onTap: () {
                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) => SignIn()),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                         //     color: Color(0xffE7EEFF),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'LOGIN',
                                                  style: TextStyle(
                                                      color: GoloColors.primary,
                                                      fontSize: sizer(true,14,context),
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                SizedBox(width: 10),
                                                Container(
                                                  width: 14,
                                                  height: 14,
                                                  decoration: BoxDecoration(
                                                    color: GoloColors.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.keyboard_arrow_right,
                                                    size: 10.0,
                                                    color: Colors.white,
                                                  )),
                                                )
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                                SizedBox(height: sizer(false,7,context)),
                                HeaderText(title: 'Welcome,'),
                                SizedBox(height: sizer(false,7,context)),
                                Text('Create an account',
                                    style: TextStyle(
                                        color: GoloColors.secondary1,
                                        fontSize: 28)),
                                SizedBox(height: sizer(false, 50, context)),
                                new Form(
                                  key: _formKey,
                                  autovalidate: _autoValidate,
                                  child: customForm(),
                                )
                              ]))))),
          isLoading: widget.loading,
        ));
  }

  Widget customForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: AuthTextInput(
              hintText: 'Full Name',
              onChanged: (text) {
                fullName = text;
              }),
        ),
         Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: AuthEmailInput(
              hintText: 'Email',
              onChanged: (text) {
                email = text;
              }),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: AuthPasswordInput(
              hintText: 'Create a Password',
              onChanged: (text) {
                password = text;
              }),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 80, context)),
          child: AuthPasswordInput(
              hintText: 'Confirm Password',
              onChanged: (text) {
                passwordConfirm = text;
              }),
        ),
        ButtonBlue(
            onPressed: () {
              preRegister();
            },
            title: 'SIGN UP'),
        SizedBox(height: sizer(false, 32, context)),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'By signing up you agree to our ',
            style: TextStyle(color: Color(0xff828A95), fontSize: sizer(true,14,context)),
            children: <TextSpan>[
              TextSpan(
                  text: 'terms of service ',
                  style: TextStyle(color: GoloColors.primary)),
              TextSpan(text: '& '),
              TextSpan(
                  text: 'privacy policy ',
                  style: TextStyle(color: GoloColors.primary))
            ],
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
