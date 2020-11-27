
import 'package:Instahelp/modules/services/platform/lara/lara.dart';
import 'package:Instahelp/src/entity/Base.dart';

class User extends Base {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String avatar;
  String phoneNumber;
  String facebook;
  String instagram;
  int isAdmin;
  int status;
  String apiToken;
  String createdAt;
  String updatedAt;
  String stripeId;
  String cardBrand;
  String cardLastFour;
  String trialEndsAt;


  User(Map<String, dynamic> json) : super(json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    avatar = json['avatar'];
    phoneNumber = json['phone_number'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    isAdmin = json['is_admin'];
    status = json['status'];
    apiToken = json['api_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stripeId = json['stripe_id'];
    cardBrand = json['card_brand'];
    cardLastFour = json['card_last_four'];
    trialEndsAt = json['trial_ends_at'];
  }
  factory User.fromJson(Map<String, dynamic> json) {
    return User(json);
  }
    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['avatar'] = this.avatar;
    data['phone_number'] = this.phoneNumber;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['is_admin'] = this.isAdmin;
    data['status'] = this.status;
    data['api_token'] = this.apiToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['stripe_id'] = this.stripeId;
    data['card_brand'] = this.cardBrand;
    data['card_last_four'] = this.cardLastFour;
    data['trial_ends_at'] = this.trialEndsAt;
    return data;
  }
}