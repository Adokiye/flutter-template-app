import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Instahelp/modules/setting/colors.dart';
import 'package:Instahelp/modules/setting/fonts.dart';
import 'package:Instahelp/modules/state/AppState.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Instahelp/src/entity/City.dart';
import 'package:Instahelp/src/entity/PlaceAmenity.dart';
import 'package:Instahelp/src/entity/PlaceCategory.dart';
import 'package:Instahelp/src/entity/PlaceType.dart';
import 'package:Instahelp/src/entity/Post.dart';
import 'package:Instahelp/src/providers/request_services/Api+city.dart';
import 'package:Instahelp/src/providers/request_services/PlaceProvider.dart';
import 'package:Instahelp/src/providers/request_services/Api+post.dart';
import 'package:Instahelp/src/providers/request_services/query/PageQuery.dart';
import 'package:Instahelp/src/views/main/DashboardTabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Instahelp/src/entity/User.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Container(
              height: 275,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image(
                        image: AssetImage('assets/app/launch/logo.png'),
                        fit: BoxFit.contain),
                    Column(
                      children: <Widget>[
                        Text(
                          "Instahelp",
                          style: TextStyle(
                              fontFamily: GoloFont,
                              fontSize: 50,
                              fontWeight: FontWeight.w500,
                              color: GoloColors.secondary1),
                        ),
                        Text(
                          "Business Listing",
                          style: TextStyle(
                              fontFamily: GoloFont,
                              fontSize: 22,
                              color: GoloColors.secondary1),
                        )
                      ],
                    ),
                    Container(
                      height: 50,
                      child: SpinKitChasingDots(
                        color: GoloColors.primary,
                        size: 45,
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Container(
            //   alignment: Alignment.bottomCenter,
            //   child: Container(
            //     alignment: Alignment.bottomCenter,
            //     height: 100,
            //     child: Column(
            //           children: <Widget>[
            //             Text(
            //               "",
            //               style: TextStyle(
            //                   fontFamily: GoloFont,
            //                   fontSize: 17,
            //                   fontWeight: FontWeight.w500,
            //                   color: GoloColors.secondary1),
            //             ),
            //             Text(
            //               "2020 © uxper.co",
            //               style: TextStyle(
            //                   fontFamily: GoloFont,
            //                   fontSize: 15,
            //                   color: GoloColors.secondary2),
            //             )
            //           ],
            //         ),
            // ))
          )
        ],
      ),
    );
  }

  // ### Navigation
  void openDashboard() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => DashboardTabs()));
  }

  // ### Fetch Data
  void loadData() async {
    await Future.wait([fetchToken(),fetchAllCities(), fetchPosts(),])
        .then((value) {
      print('ggg');
      openDashboard();
    });
  }

  Future fetchToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (await prefs.getString('token') ?? '');
    print(token);
    String user = (await prefs.getString('user') ?? '');
    AppState().user = user != ''?User.fromJson(json.decode(user)):null;
    return AppState().token = token;
  }

  Future fetchPopularCities() async {
   
    return ApiCity.fetchCitiesPopular().then((response) {
      AppState().popularCities = List<City>.generate(
          response.data.length, (i) => City.fromJson(response.data[i]));
    });
  }

  Future fetchAllCities() async {
    return ApiCity.fetchCities().then((response) {
      print(response.data);
      AppState().cities = List<City>.generate(
          response.data.length, (i) => City.fromJson(response.data[i]));
    });
  }

  Future fetchCategories() async {
    return ApiCity.fetchCategories().then((response) {
      AppState().categories = List<PlaceCategory>.generate(response.data.length,
          (i) => PlaceCategory.fromJson(response.data[i]));
    });
  }

  Future fetchAmenities() async {
    return ApiCity.fetchAmenities().then((response) {
      AppState().amenities = List<PlaceAmenity>.generate(
          response.data.length, (i) => PlaceAmenity.fromJson(response.data[i]));
    });
  }

  Future fetchPlaceTypes() async {
    return PlaceProvider.getPlaceTypes(query: PageQuery(50, 1))
        .then((response) {
      AppState().placeTypes = List<PlaceType>.generate(
          response.data.length, (i) => PlaceType.fromJson(response.data[i]));
    });
  }

  // Post
  Future fetchPosts() async {
    return ApiPost.fetchPosts().then((response) {
      AppState().posts = List<Post>.generate(
          response.data.length, (i) => Post(response.data[i]));
    });
  }
}
