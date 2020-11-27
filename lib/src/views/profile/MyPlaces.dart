import 'package:Instahelp/components/emptyData.dart';
import 'package:Instahelp/src/providers/request_services/Api+auth.dart';
import 'package:Instahelp/src/views/auth/signin.dart';
import 'package:Instahelp/src/views/profile/AddPlace.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:Instahelp/modules/setting/fonts.dart';
import 'package:Instahelp/modules/state/AppState.dart';
import 'package:Instahelp/src/blocs/navigation/NavigationBloc.dart';
import 'package:Instahelp/src/entity/City.dart';
import 'package:Instahelp/src/views/wishlist/controls/CityCell.dart';

class MyPlaces extends StatefulWidget {
  MyPlaces({
    Key key,
  }) : super(key: key);

  @override
  _MyPlacesState createState() {
    return _MyPlacesState();
  }
}

class _MyPlacesState extends State<MyPlaces> {
  @override
  void initState() {
    super.initState();
    ApiAuth.fetchPlaces().then((response) {
      AppState().myPlaces = List<City>.generate(
          response.data.length, (i) => City.fromJson(response.data[i]));
    });
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
        padding: EdgeInsets.only(top: 40, left: 20, right: 20),
        children: <Widget>[
          // ### 1. Header
          Container(
            margin: const EdgeInsets.only(
              top: 20,
              left: 25,
              right: 25,
            ),
            height: 60,
            child: Text(
              "WishList",
              style: TextStyle(
                  fontFamily: GoloFont,
                  fontWeight: FontWeight.w600,
                  fontSize: 32),
            ),
          ),
          AppState().myPlaces.length > 1
              ? Flexible(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: _buildMyPlacesGridView()),
                )
              : Column(children: <Widget>[
                  // #7 padding bottom
                  SizedBox(height: 80),
                  EmptyData(
                      title: 'You have no places currently',
                      isButton: true,
                      buttonText: 'ADD PLACE',
                      buttonFn: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => AddPlace()),
                        );
                      }),
                ])
        ],
        scrollDirection: Axis.vertical,
      ),
    ));
  }

  // ### City list
  Widget _buildMyPlacesGridView() => new GridView.count(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      crossAxisCount: 2,
      childAspectRatio: 0.715,
      children: List.generate(AppState().myPlaces.length, (index) {
        return _buildMyPlacesCell(index);
      }));

  Widget _buildMyPlacesCell(int imageIndex) => Container(
      child: Container(
          margin: EdgeInsets.only(right: 8, bottom: 8),
          height: 350,
          child: GestureDetector(
            child: CityCell(city: AppState().myPlaces[imageIndex]),
            onTap: () {
              HomeNav(context).openCity(AppState().myPlaces[imageIndex]);
            },
          )));
}
