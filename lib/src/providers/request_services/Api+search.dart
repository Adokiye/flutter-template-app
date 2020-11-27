
import 'dart:convert';

import 'package:Instahelp/modules/services/http/Api.dart';
import 'package:Instahelp/modules/services/platform/Platform.dart';
import 'package:Instahelp/src/providers/request_services/response/ResponseListData.dart';

class ApiSearch {

  static Future<ResponseData> searchPlaces(String text) {
    var url = Platform().shared.baseUrl + "app/places/search?keyword=$text";
    return Api.requestGet(url).then((data) {
      var jsonObj = json.decode(data.data) as Map;
      var jsonData = jsonObj["data"]["places"];
      return ResponseData(jsonData, data.error);
    });
  }
}