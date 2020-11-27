import 'package:flutter/material.dart';
import 'package:Instahelp/components/headerText.dart';
import 'package:Instahelp/components/subText.dart';
import 'package:Instahelp/helpers/sizeCalculator.dart';
import 'package:Instahelp/components/buttonBlue.dart';
import 'package:Instahelp/components/backButtonWhite.dart';
import 'package:Instahelp/components/authTextInput.dart';
import 'package:Instahelp/components/authSelectInput.dart';
import 'package:Instahelp/components/authEmailInput.dart';
import 'package:Instahelp/components/authPhoneInput.dart';

class AddPlace extends StatefulWidget {
  AddPlace({Key key, }) : super(key: key);

  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
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
                            BackButtonWhite(onPressed: (){},),
                          ],
                        ),
                        SizedBox(height: sizer(false,15,context)),
                              HeaderText(title: 'Add Place'),
                              SizedBox(height: 8,),
                              SubText(isCenter: false,
                              title: 'Fill in information to add place'),
                              SizedBox(height: sizer(false,15,context)),
                            new Form(
                            key: _formKey,
                            autovalidate: _autoValidate,
                            child: customForm(),
                          ),
                        ]
                        ),
                        
                        )
                        )
                        )
                        )
    );
  }

    Widget customForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: AuthTextInput(hintText: 'First Name', onChanged: (text) {})),
                  
                SizedBox(width: 16.0),
                Expanded(
                    child: AuthTextInput(hintText: 'Last Name', onChanged: (text) {}),
                  )
              ],
            )),
            Container(
            margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: AuthSelectInput(hintText: 'Genotype', onPressed: () {})),
                  
                SizedBox(width: 16.0),
                Expanded(
                    child: AuthSelectInput(hintText: 'DOB', onPressed: () {}),
                  )
              ],
            )),
        
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: AuthPhoneInput(hintText: 'Phone number', onChanged: (text) {}),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: AuthEmailInput(hintText: 'Email Address', onChanged: (text) {}),
        ),
        ButtonBlue(onPressed: () {
    
        }, title: 'NEXT'),
        SizedBox(height: sizer(false, 32, context)),
        SizedBox(height: 10)
      ],
    );
  }
}
