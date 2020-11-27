import 'dart:convert';

import 'package:Instahelp/modules/services/platform/Platform.dart';
import 'package:Instahelp/modules/services/http/ApiToken.dart';
import 'package:Instahelp/src/entity/User.dart';
import 'package:Instahelp/src/providers/request_services/query/PageQuery.dart';
import 'package:Instahelp/src/providers/request_services/response/ResponseListData.dart';
import 'package:Instahelp/modules/state/AppState.dart';

class ApiAuth {
  static Future<ResponseListData> fetchWishlist() {
    var url = Platform().shared.baseUrl +
        "app/users/" +
        AppState().user.id.toString() +
        "/place/wishlist";
    return ApiToken.requestGet(url).then((data) {
      print(data.data);
      var jsonObj = {};
      if (data != null && data.data != null) {
        var jsonData = json.decode(data.data);
        return ResponseListData(jsonData, data.error);
      } else {
        return ResponseListData([], '');
      }
    });
  }

    static Future<ResponseListData> addToWishlist(Map<String, dynamic> body) {
    var url = Platform().shared.baseUrl +
        "app/users/" +
        AppState().user.id.toString() +
        "/place/wishlist";
    return ApiToken.requestPost(url,body).then((data) {
      print(data.data);
      var jsonObj = {};
      if (data != null && data.data != null) {
        var jsonData = json.decode(data.data);
        return ResponseListData(jsonData, data.error);
      } else {
        return ResponseListData([], '');
      }
    });
  }

  static Future<ResponseListData> fetchPlaces() {
    var url = Platform().shared.baseUrl +
        "app/users/" +
        AppState().user.id.toString() +
        "/place";
    return ApiToken.requestGet(url).then((data) {
      print(data.data);
      var jsonObj = {};
      if (data != null && data.data != null) {
        var jsonData = json.decode(data.data);
        return ResponseListData(jsonData, data.error);
      } else {
        return ResponseListData([], '');
      }
    });
  }

  static Future<User> fetchUser() {
    var url = Platform().shared.baseUrl + "app/users";
    return ApiToken.requestGet(url).then((data) {
      print(data.data);
      if (data != null && data.data != null) {
        User jsonData = User.fromJson(data.data);
        return jsonData;
      } else {
        return null;
      }
    });
  }

  //payment
    static Future<ResponseListData> addCard(Map<String,dynamic> body) {
    var url = Platform().shared.baseUrl + "app/user/payment-info/card/new";
    return ApiToken.requestPost(url, body).then((data) {
      print(data.data);
      if (data != null && data.data != null) {
        var jsonData = json.decode(data.data);
        return ResponseListData(jsonData, data.error);
      } else {
        return ResponseListData([], '');
      }
    });
  }

      static Future<ResponseListData> getPlans() {
    var url = Platform().shared.baseUrl + "app/user/payment-info";
    return ApiToken.requestGet(url).then((data) {
      print(data.data);
      if (data != null && data.data != null) {
        var jsonData = json.decode(data.data);
        return ResponseListData(jsonData, data.error);
      } else {
        return ResponseListData([], '');
      }
    });
  }

      static Future<ResponseListData> subscribe(Map<String,dynamic> body) {
    var url = Platform().shared.baseUrl + "app/user/subscription/subscribe";
    return ApiToken.requestPost(url, body).then((data) {
      print(data.data);
      if (data != null && data.data != null) {
        var jsonData = json.decode(data.data);
        return ResponseListData(jsonData, data.error);
      } else {
        return ResponseListData([], '');
      }
    });
  }
}
