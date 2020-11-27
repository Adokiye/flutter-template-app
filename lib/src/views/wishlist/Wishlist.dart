import 'package:Instahelp/components/emptyData.dart';
import 'package:Instahelp/src/providers/request_services/Api+auth.dart';
import 'package:Instahelp/src/views/auth/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:Instahelp/modules/setting/fonts.dart';
import 'package:Instahelp/modules/state/AppState.dart';
import 'package:Instahelp/src/blocs/navigation/NavigationBloc.dart';
import 'package:Instahelp/src/entity/City.dart';
import 'package:Instahelp/src/views/wishlist/controls/CityCell.dart';

class Wishlist extends StatefulWidget {
  final List<City> cities;
  final bool isLoggedIn;
  final VoidCallback homeOpenAllCities;

  Wishlist({Key key, this.cities, @required this.isLoggedIn,
  @required this.homeOpenAllCities}) : super(key: key);

  @override
  _WishlistState createState() {
    return _WishlistState();
  }
}

class _WishlistState extends State<Wishlist> {
  @override
  void initState() {
    super.initState();
    if(widget.isLoggedIn){
      ApiAuth.fetchWishlist().then((response) {
        print(response);
      // AppState().popularCities = List<City>.generate(
      //     response.data.length, (i) => City.fromJson(response.data[i]));
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
            child: Text("WishList",
              style: TextStyle(
                  fontFamily: GoloFont,
                  fontWeight: FontWeight.w600,
                  fontSize: 32),
            ),
          ),
          AppState().popularCities.length > 1 ?
Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: _buildWishlistGridView()
                ),
              )
          :Column(
            children:<Widget>[
               // #7 padding bottom
          SizedBox(height:80),
          EmptyData(title:'You have no places in your wishlist',
          isButton:true,buttonText:'ADD TO WISHLIST',
          buttonFn:(){
                if(!widget.isLoggedIn){
      Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) => SignIn()),
                                            );
    }else{
      return widget.homeOpenAllCities();
    }
          }),
            ]
          )
        ],
        scrollDirection: Axis.vertical,
      ),
    ));
  }

    // ### City list
  Widget _buildWishlistGridView() => new GridView.count(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        crossAxisCount: 2,
        childAspectRatio: 0.715,
        children: List.generate(AppState().popularCities.length, (index) {
            return _buildWishlistCell(index);
        })
      );

  Widget _buildWishlistCell(int imageIndex) => Container(
          child: Container(
        margin: EdgeInsets.only(right: 8, bottom: 8),
        height: 350,
        child: GestureDetector(
        child: CityCell(city: AppState().popularCities[imageIndex]),
        onTap: () {
          HomeNav(context).openCity(AppState().popularCities[imageIndex]);
        },
      )
      ));

}
