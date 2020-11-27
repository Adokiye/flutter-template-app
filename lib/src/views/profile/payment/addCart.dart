import 'package:Instahelp/components/authPhoneInput.dart';
import 'package:Instahelp/modules/setting/colors.dart';
import 'package:Instahelp/src/providers/request_services/Api+auth.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:io';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:Instahelp/components/headerText.dart';
import 'package:Instahelp/helpers/sizeCalculator.dart';
import 'package:Instahelp/components/buttonBlue.dart';
import 'package:Instahelp/components/backButtonWhite.dart';
import 'package:Instahelp/components/authTextInput.dart';

class AddCard extends StatefulWidget {
  AddCard({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String number;
  String cvv;
  String dateValue;
  bool _loading = false;
  @override
  void initState() {
    super.initState();
      StripePayment.setOptions(
        StripeOptions(publishableKey: "pk_test_51GwZ2qGH4DIiGLsSch3FLpZiT0vCn0eXUDEOB9MawVeUrf0bzdAduVD0O31NtTU8f1xd4xY0UNHjUZhD9kPoFITg00l67dFYSf",
       //  merchantId: "Test", 
         androidPayMode: 'test'));
  }

  Future<dynamic> addCard() async {
    setState(() {
      _loading = true;
    });
    Map<String, dynamic> body = {
    'number':number,
    'expMonth': dateValue.substring(0,2)+dateValue.substring(3,5),
    };
    final CreditCard testCard = CreditCard(
  number: number,
  expMonth: int.parse(dateValue.substring(0,2)),
  expYear: int.parse(dateValue.substring(3,5)),
);
    ApiAuth.addCard(body).then((response) {
     setState(() {
      _loading = false;
    });
    });

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
                              HeaderText(title: 'Add card'),
                              SizedBox(height: 28),
                              new Form(
                            key: _formKey,
                            autovalidate: _autoValidate,
                            child: customForm(),
                          )
                        ]
                        ),
                        
                        )
                        )
                        )
                        ),
                        isLoading: _loading,
   ));
  }

    Widget customForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: AuthPhoneInput(hintText: 'Card Number', onChanged: (text) {
            number=text;
          }),
        ),
           Container(
            margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: AuthPhoneInput(hintText: 'MM/YY', onChanged: (text) {
                    if(text.length ==2){
                        if(dateValue.indexOf('/') == -1){
                           text+= text+'/';
                         }
                    }
                    dateValue = text;
                  })),
                  
                SizedBox(width: 16.0),
                Expanded(
                    child: AuthPhoneInput(hintText: 'CVV', onChanged: (text) {
                      cvv = text;
                    }),
                  )
              ],
            )),
        ButtonBlue(onPressed: () =>addCard(), title: 'ADD CARD'),
      ],
    );
  }
}
