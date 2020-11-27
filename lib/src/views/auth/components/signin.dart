import 'package:Instahelp/modules/setting/colors.dart';
import 'package:flutter/material.dart';
import 'package:Instahelp/components/headerText.dart';
import 'package:Instahelp/components/authPasswordInputTest.dart';
import 'package:Instahelp/components/authEmailInput.dart';
import 'package:Instahelp/helpers/sizeCalculator.dart';
import 'package:Instahelp/components/buttonBlue.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../signup.dart';

class SignInBody extends StatefulWidget {
  SignInBody({Key key, this.title, this.loginFn, this.loading}) : super(key: key);
  final String title;
  final Function loginFn;
  final bool loading;

  @override
  _SignInBodyState createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
  }

     void preLogin() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to our variables
      _formKey.currentState.save();
      Map<String, dynamic> body = {
       'email': _email,
       'password': _password,
      };
      widget.loginFn(body);
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
            child:  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child:new SingleChildScrollView(
                child: Padding( padding: EdgeInsets.only(
                        top: sizer(false, 100, context), left: sizer(true,25,context), right: sizer(true,25,context)),
                child:Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    borderRadius: BorderRadius.circular(5.0),
                                    // side: BorderSide(color: Colors.red)
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                          Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SignUp()),
    );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                    //    color: Color(0xffE7EEFF),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'SIGN UP',
                                            style: TextStyle(
                                                color: GoloColors.primary,
                                                fontSize: sizer(true,14,context),
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            width: 14,
                                            height: 14,
                                            decoration: BoxDecoration(
                                              color: GoloColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                          HeaderText(title: 'Welcome Back,'),
                          SizedBox(height: sizer(false,7,context)),
                          Text('Sign in',
                              style: TextStyle(
                                  color: GoloColors.secondary1, fontSize: 28)),
                          SizedBox(height: sizer(false, 93, context)),
                          new Form(
                            key: _formKey,
                            autovalidate: _autoValidate,
                            child: customForm(),
                          )
                        ]))))),
                        isLoading: widget.loading,));
  }

  Widget customForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: AuthEmailInput(hintText: 'Email Address', onChanged: (text) {
            _email = text;
          }),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 116, context)),
          child: AuthPasswordInputTextTest(
              hintText: 'Password', onChanged: (text) {
                _password = text;
              }),
        ),
        ButtonBlue(onPressed: () {
                                                preLogin();
        }, title: 'LOG IN'),
      ],
    );
  }
}
