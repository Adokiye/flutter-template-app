import 'package:Instahelp/modules/setting/colors.dart';
import 'package:Instahelp/src/providers/request_services/Api+auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Instahelp/components/headerText.dart';
import 'package:Instahelp/components/subText.dart';
import 'package:Instahelp/helpers/sizeCalculator.dart';
import 'package:Instahelp/components/plusButton.dart';
import 'package:Instahelp/components/backButtonWhite.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentMethods extends StatefulWidget {
  PaymentMethods({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PaymentMethodsState createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PaymentMethod _paymentMethod;
  bool _loading = false;
  String _error;

  @override
  void initState() {
    super.initState();
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51GwZ2qGH4DIiGLsSch3FLpZiT0vCn0eXUDEOB9MawVeUrf0bzdAduVD0O31NtTU8f1xd4xY0UNHjUZhD9kPoFITg00l67dFYSf",
        //  merchantId: "Test",
        androidPayMode: 'test'));
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _loading = false;
      _error = error.toString();
    });
  }

  Future<dynamic> addCard() async {
    setState(() {
      _loading = true;
    });
    StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
        .then((paymentMethod) {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text('Received ${paymentMethod.id}')));
      setState(() {
        _paymentMethod = paymentMethod;
      });
    }).catchError(setError);
    Map<String, dynamic> body = {
      'payment_method': _paymentMethod.id,
    };
    ApiAuth.addCard(body).then((response) {
      print(response);
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
                        top: sizer(false, 77, context),
                        left: sizer(true, 25, context),
                        right: sizer(true, 25, context)),
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
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SizedBox(height: sizer(false, 15, context)),
                          HeaderText(title: 'Billing Details'),
                          SizedBox(height: 28),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Manage Cards',
                                style: TextStyle(
                                    color: Color(0xff8E919C),
                                    fontSize: sizer(true, 20, context)),
                              ),
                              PlusButton(onPressed: () {
                                return addCard();
                                //                             Navigator.of(context).push(
                                //   MaterialPageRoute(builder: (_) => AddCard(title: ''))
                                // );
                              }),
                            ],
                          ),
                          SizedBox(height: 36),
                          card('Mastercard', '3878'),
                          card('Mastercard', '3878'),
                          card('Mastercard', '3878'),
                          card('Mastercard', '3878'),
                        ]),
                  )))),
          isLoading: _loading,
        ));
  }

  Widget card(String type, String lastDigits) {
    return Container(
      margin: EdgeInsets.only(bottom: sizer(false, 10, context)),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xff2254D3),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(34, 84, 211, 0.3),
            spreadRadius: 3,
            //   blurRadius: 7,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/cardIcon.png',
            width: 26,
            height: 16,
          ),
          SizedBox(width: 10),
          Text(type,
              style: TextStyle(
                  color: Colors.white, fontSize: sizer(true, 20, context))),
          SizedBox(width: 6),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
          ),
          SizedBox(width: 6),
          Text(lastDigits,
              style: TextStyle(
                  color: Colors.white, fontSize: sizer(true, 20, context))),
          Spacer(),
          Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                // side: BorderSide(color: Colors.red)
              ),
              color: Color(0xff436dda),
              child: InkWell(
                  onTap: () {},
                  child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Color(0xff436dda),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.delete,
                        size: 16,
                        color: Colors.white,
                      ))))
        ],
      ),
    );
  }
}
