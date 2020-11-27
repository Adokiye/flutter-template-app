

import 'dart:convert';

import 'package:Instahelp/modules/services/http/Api.dart';
import 'package:Instahelp/modules/services/platform/Platform.dart';
import 'package:Instahelp/src/providers/request_services/query/PageQuery.dart';
import 'package:Instahelp/src/providers/request_services/response/ResponseListData.dart';

class ApiPost {
  static Future<ResponseListData> fetchPosts({PageQuery query}) {
    var url = Platform().shared.baseUrl + "posts/inspiration";
    return Api.requestGetPaging(url, query).then((data) {
      print('---');
      print(data.data);
      print('---');
      if(data != null && data.data != null){
      var jsonObj = json.decode(data.data) as Map;
      var jsonData = jsonObj["data"] as List;      
      return ResponseListData(jsonData, data.error);
      }else{
        return ResponseListData([], '');
      }

    });
  }

  

  
}