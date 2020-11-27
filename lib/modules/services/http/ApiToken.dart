import 'dart:core';
import 'dart:async';
import 'package:Instahelp/src/providers/request_services/query/PageQuery.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Instahelp/modules/state/AppState.dart';

class ResponseData {
  dynamic data;
  String error;
  ResponseData(this.data, this.error);
}

enum RequestType {
  Get,
  Post
}

class ApiToken {
  // POST
  static Future<ResponseData> requestPost(String api, Map<String, dynamic> body) {
    return _request(RequestType.Post, _makeUrl(api), body: body);
  }

  // GET
  static Future<ResponseData> requestGet(String api) async {
    return await _request(RequestType.Get, _makeUrl(api));
  }

  static Map<String, dynamic> headers =    {
            "Connection": 'keep-alive',
            "Authorization": "Bearer " + AppState().token
          };

  // REQUEST
  static Future<ResponseData> _request(RequestType type, String url, {Map<String, dynamic> body}) async {
    // make request
    Response response;
    switch (type) {
      case RequestType.Get:
        response = await get(url,headers: headers,);
        break;
      case RequestType.Post:
        response = await post(url,headers: headers, body: body);
        break;
    }
    // sample info available in response
    int statusCode = response.statusCode;
      print(response.request);
    if (statusCode == 200) {
    
      return ResponseData(response.body, null);
    }
    return ResponseData(null, "Error");
  }

  static String _makeUrl(String api) {
    var params = [];
    // if (query != null) {
    //   query.forEach((key, value) {
    //     params.add(key + "=" + value);
    //   });
    // }
    // else {
      return api;
    // }
    if (api.contains("?")) {
      if (api.endsWith("?")) {
        return api + params.join("&");
      }
      return api + "&" + params.join("&");
    }
    return api + "?" + params.join("&");
  }
}
