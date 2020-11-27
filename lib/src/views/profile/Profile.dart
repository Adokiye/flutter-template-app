import 'package:Instahelp/components/accountListItem.dart';
import 'package:Instahelp/components/mediumText.dart';
import 'package:Instahelp/helpers/sizeCalculator.dart';
import 'package:Instahelp/modules/setting/colors.dart';
import 'package:Instahelp/src/providers/request_services/Api+auth.dart';
import 'package:Instahelp/src/views/auth/signin.dart';
import 'package:Instahelp/src/views/profile/MyPlaces.dart';
import 'package:Instahelp/src/views/profile/ProfileSetting.dart';
import 'package:Instahelp/src/views/profile/payment/Subscription.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:Instahelp/modules/setting/fonts.dart';
import 'package:Instahelp/modules/state/AppState.dart';
import 'package:Instahelp/src/entity/User.dart';
import 'package:Instahelp/components/emptyData.dart';

const String baseUrlImage = "https://insta-help.s3.amazonaws.com/";

class Profile extends StatefulWidget {
  final bool isLoggedIn;

  Profile({Key key, @required this.isLoggedIn,}) : super(key: key);

  @override
  _ProfileState createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    if(widget.isLoggedIn){
      ApiAuth.fetchUser().then((response) {
      AppState().user = response;
    });
    }
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: ListView(
        padding: EdgeInsets.only(top: 40,left:20,right:20),
        children: <Widget>[
          // ### 1. Header
          Container(
            margin: const EdgeInsets.only(
              top: 20,
              left: 25,
              right: 25,
            ),
            height: 60,
            child: Text("Profile",
              style: TextStyle(
                  fontFamily: GoloFont,
                  fontWeight: FontWeight.w600,
                  fontSize: 32),
            ),
          ),
          // #7 padding bottom
          widget.isLoggedIn ?EmptyData(isButton:true,title:'You\'re not logged in, Login to view your Profile',
          buttonText: 'LOGIN',buttonFn:(){
             Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) => SignIn()),
                                            );
          }):
          new SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: sizer(false, 77, context),
                            left: sizer(true,25,context),right: sizer(true,25,context)),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                       SizedBox(height: sizer(false,5,context)),
                                       MediumText(title: 'Manage your account')
                                    ],
                                  ),
                                     ClipRRect(
                          borderRadius: BorderRadius.circular(22.5),
                          child: Image.network(baseUrlImage+AppState().user.avatar,
                              fit: BoxFit.cover, width: 45, height: 45)),
                                ],
                              ),
                              SizedBox(height: 30),
                              Text('Profile', style: TextStyle(
                                color: GoloColors.primary,
                                fontSize: sizer(true,16.0,context),
                                fontWeight: FontWeight.w600
                              )),
                              SizedBox(height: 25),
                        AccountListItem(title: 'Profile', onPressed: (){
                            Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ProfileSetting()),
      );
                        }),
                        AccountListItem(title: 'My Places', onPressed: (){
                            Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => MyPlaces()),
      );
                        }),
                        SizedBox(height: sizer(false,45,context)),
                          Text('Payment Info', style: TextStyle(
                                color: Color(0xff2254D3),
                                fontSize: sizer(true,16.0,context),
                                fontWeight: FontWeight.w600
                              )),
                              SizedBox(height: 25),
      //                   AccountListItem(title: 'Payment Methods', onPressed: (){
      //                       Navigator.of(context).push(
      //   MaterialPageRoute(builder: (_) => PaymentMethods()),
      // );
      //                   }),
                        AccountListItem(title: 'Subscriptions', onPressed: (){
                            Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => Subscription()),
      );
                        }),

                            ]
                            ))),
          Container(height: 50),
        ],
        scrollDirection: Axis.vertical,
      ),
    ));
  }

}
