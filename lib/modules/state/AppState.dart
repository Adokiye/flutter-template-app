

import 'package:Instahelp/src/entity/City.dart';
import 'package:Instahelp/src/entity/PlaceAmenity.dart';
import 'package:Instahelp/src/entity/PlaceCategory.dart';
import 'package:Instahelp/src/entity/PlaceType.dart';
import 'package:Instahelp/src/entity/Post.dart';
import 'package:Instahelp/src/entity/User.dart';

class AppState {
  static final AppState _instance = AppState._internal();

  factory AppState() {
    return _instance;
  }
  // Cities
  List<City> cities = [];
    // myPlaces
  List<City> myPlaces = [];
  // Popular cities (Home screen)
  List<City> popularCities = [];
  // Categories | Amenities
  List<PlaceCategory> categories = [];
  List<PlaceAmenity> amenities = [];
  // Posts
  List<Post> posts = [];
  // Place of current city
  // City currentCity;
  // List<Place> places = [];
  List<PlaceType> placeTypes = [];

  String token = '';

  User user;

  AppState._internal() {
    
  }

  // void clearCurrentCity() {
    // currentCity = null;
    // places.clear();
  // }

}