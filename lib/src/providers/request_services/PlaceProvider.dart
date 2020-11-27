
import 'dart:convert';

import 'package:Instahelp/modules/services/http/Api.dart';
import 'package:Instahelp/modules/services/platform/Platform.dart';
import 'package:Instahelp/src/entity/Review.dart';
import 'package:Instahelp/src/providers/request_services/query/PageQuery.dart';
import 'package:Instahelp/src/providers/request_services/response/ResponseListData.dart';

class PlaceProvider {


  static Future<ResponseListData> getFeature(String cityId, {PageQuery query}) {
    var url = Platform().shared.baseUrl + "app/cities/$cityId";
    return Api.requestGetPaging(url, query).then((data) {
      var placesJson = data.data != null ? json.decode(data.data) as Map : null;
      var jsonData = placesJson["data"]["features"] as List;      
      return ResponseListData(jsonData, data.error);
    });
  }
  
  static Future<ResponseData> getPlaceDetail(String placeId, {PageQuery query}) {
    var url = Platform().shared.baseUrl + "app/places/$placeId";
    return Api.requestGet(url).then((data) {
      var jsonData = data.data != null ? json.decode(data.data) : null;
      return ResponseData(jsonData,data.error);
    });
  }

  static Future<ResponseListData> getPlaceTypes({PageQuery query}) {
    var url = Platform().shared.baseUrl + "place-type";
    return Api.requestGetPaging(url, query).then((data) {
      var typesJson = data.data != null ? json.decode(data.data) : null;
      return ResponseListData(typesJson, data.error);
    });
  }

  static Future<List<Review>> getPlaceComments(int placeId, {PageQuery query}) {
    var url = Platform().shared.baseUrl + "comments?post=$placeId";
    return Api.requestGetPaging(url, query).then((response) {
      List<dynamic> items = json.decode(response.data);
      if (items != null && items.length > 0) {
          return List<Review>.generate(items.length, (i) => Review(items[i]));
      }
      return null;
    });
  }

}