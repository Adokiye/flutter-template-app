import 'dart:convert';

import 'package:Instahelp/modules/services/platform/Platform.dart';
import 'package:Instahelp/modules/services/http/Api.dart';
import 'package:Instahelp/src/providers/request_services/query/PageQuery.dart';
import 'package:Instahelp/src/providers/request_services/response/ResponseListData.dart';



class ApiCity {
  static Future<ResponseListData> fetchCities({PageQuery query}) {
    var url = Platform().shared.baseUrl + "cities";
    return Api.requestGetPaging(url, query).then((data) {
      print(data.data);
      var jsonObj = {};
      if(data != null && data.data != null){
   //   jsonObj = json.decode(data.data) as Map;
      var jsonData = json.decode(data.data);      
      return ResponseListData(jsonData, data.error);
      }else{
       return ResponseListData([],'');
      }

    });
  }

  static Future<ResponseListData> fetchCitiesPopular({PageQuery query}) {
    var url = Platform().shared.baseUrl + "cities/popular";
    return Api.requestGetPaging(url, query).then((data) {
      var jsonObj = {};
      if(data != null && data.data != null && data.data.length > 0 ){
    //  print('---');
    //   print(data.data);
    //  print('---');

    //   jsonObj = json.decode(data.data) as Map;
    //   var jsonData = jsonObj["data"] as List;      
      return ResponseListData([], '');
      }else{
        print('h');
       return ResponseListData([],'');
      }
    });
  }

  static Future<ResponseData> fetchCity(String id) {
    var url = Platform().shared.baseUrl + "cities/$id";
    
    return Api.requestGet(url);
  }

  // Category
  static Future<ResponseListData> fetchCategories({PageQuery query}) {
    var url = Platform().shared.baseUrl + "place-categories";
    return Api.requestGetPaging(url, query).then((data) {
            var jsonObj = {};
      if(data != null && data.data != null){
      jsonObj = json.decode(data.data) as Map;
      var jsonData = jsonObj["data"] as List;      
      return ResponseListData(jsonData, data.error);
      }else{
        print('hh');

       return ResponseListData([],'');
      }
    });
  }

  // Amenities
  static Future<ResponseListData> fetchAmenities({PageQuery query}) {
    var url = Platform().shared.baseUrl + "place-amenities";
    return Api.requestGetPaging(url, query).then((data) {
      var jsonObj = {};
      if(data != null && data.data != null){
      jsonObj = json.decode(data.data) as Map;
      var jsonData = jsonObj["data"] as List;      
      return ResponseListData(jsonData, data.error);
      }else{
        print('hhh');

       return ResponseListData([],'');
      }
    });
  }
  
}
