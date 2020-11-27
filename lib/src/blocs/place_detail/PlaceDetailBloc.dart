import 'dart:async';

import 'package:Instahelp/modules/setting/setting.dart';
import 'package:Instahelp/src/blocs/Bloc.dart';
import 'package:Instahelp/src/entity/PlaceCategory.dart';
import 'package:Instahelp/src/entity/PlaceType.dart';
import 'package:Instahelp/src/entity/Review.dart';
import 'package:Instahelp/src/entity/Place.dart';
import 'package:Instahelp/src/entity/PlaceAmenity.dart';
import 'package:Instahelp/src/providers/request_services/PlaceProvider.dart';


class PlaceDetailBloc implements Bloc {
  // Data
  List<PlaceAmenity> amenities = [];
  List<Review> reviews = [];
  List<Place> similarPlaces = [];
  List<PlaceCategory> categories = [];
  List<PlaceType> placeTypes = [];
  Place _place;
  // Stream 
  final _placeController = StreamController<Place>.broadcast();
  Stream<Place> get placeController => _placeController.stream;

  PlaceDetailBloc(Place place): super(){
    _place = place;
  }

  void fetchData(int placeId) async{
    final response = await PlaceProvider.getPlaceDetail("$placeId");
    print("Fetched places of city $placeId");
    if (response.error == null && response.data["data"] != null){
      // place
      if (response.data["data"]["place"] != null){
        _place = Place.fromJson(response.data["data"]["place"]);
        if (response.data["data"]["review_score_avg"] != null) {
          var r = response.data["data"]["review_score_avg"].toString();
          _place.setRate(r);
        }
      }

      // amenities
      amenities = [];
      if (response.data["data"]["amenities"].length > 0) {
        for (var json in response.data["data"]["amenities"]) {
          amenities.add(PlaceAmenity.fromJson(json));
        }
      } 
      // Reviews 
      if (response.data["data"]["reviews"].length > 0) {
        for (var json in response.data["data"]["reviews"]) {
          reviews.add(Review.fromJson(json));
        }
        _place.reviewCount = reviews.length;
      } 
      // similarPlaces
      if (response.data["data"]["similar_places"].length > 0) {
        for (var json in response.data["data"]["similar_places"]) {
          similarPlaces.add(Place.fromJson(json));
        }
      }
      if (response.data["data"]["categories"].length > 0) {
        for (var json in response.data["data"]["categories"]) {
          categories.add(PlaceCategory.fromJson(json));
        }
      }
      if (response.data["data"]["place_types"].length > 0) {
        for (var json in response.data["data"]["place_types"]) {
          placeTypes.add(PlaceType.fromJson(json));
        }
      }
      _placeController.sink.add(_place);
    }
  }

  @override
  void dispose() {
    _placeController.close();
  }
}