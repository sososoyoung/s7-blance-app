import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

class UserMember {
  int memberId;
  String nickname;
  String headPicture;
  double height;
  double weight;
  int sex;
  String birthday;
  int myself;
  double targetWeight;
  double targetBfr;

  UserMember({
    this.memberId,
    this.nickname,
    this.headPicture,
    this.height,
    this.weight,
    this.sex,
    this.birthday,
    this.myself,
    this.targetWeight,
    this.targetBfr,
  });

  factory UserMember.fromJson(Map<String, dynamic> json) {
    return new UserMember(
      memberId: json["memberId"],
      nickname: json["nickname"],
      headPicture: json["headPicture"],
      height: json["height"],
      weight: json["weight"],
      sex: json["sex"],
      birthday: json["birthday"] as String,
      myself: json["myself"],
      targetWeight: json["targetWeight"],
      targetBfr: json["targetBfr"],
    );
  }

  Map<String, dynamic> toJson() => {
        "memberId": memberId,
        "nickname": nickname,
        "headPicture": headPicture,
        "height": height,
        "weight": weight,
        "sex": sex,
        "birthday": birthday,
        "myself": myself,
        "targetWeight": targetWeight,
        "targetBfr": targetBfr,
      };
}
// Generated by https://quicktype.io

@JsonSerializable()
class User {
  String userId;
  bool empty;
  double height;
  double weight;
  int birthday;
  int gender;
  String nickname;
  String headPictureUrl;
  String introduction;
  String refreshToken;
  String locationCode;
  String country;
  String province;
  String city;
  String county;
  dynamic qqOpenId;
  dynamic weChatOpenId;
  String token;
  int expirationTime;
  int serverTime;

  User({
    this.userId,
    this.empty,
    this.height,
    this.weight,
    this.birthday,
    this.gender,
    this.nickname,
    this.headPictureUrl,
    this.introduction,
    this.refreshToken,
    this.locationCode,
    this.country,
    this.province,
    this.city,
    this.county,
    this.qqOpenId,
    this.weChatOpenId,
    this.token,
    this.expirationTime,
    this.serverTime,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

class LoginTokens {
  String accessToken;
  String uid;
  String refreshToken;
  String refreshTokenExpire;
  String error;
  String accessTokenExpire;

  LoginTokens({
    this.accessToken,
    this.uid,
    this.refreshToken,
    this.refreshTokenExpire,
    this.error,
    this.accessTokenExpire,
  });

  factory LoginTokens.fromJson(Map<String, dynamic> json) => new LoginTokens(
        accessToken: json["access_token"],
        uid: json["uid"],
        refreshToken: json["refresh_token"],
        refreshTokenExpire: json["refresh_token_expire"],
        error: json["error"],
        accessTokenExpire: json["access_token_expire"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "uid": uid,
        "refresh_token": refreshToken,
        "refresh_token_expire": refreshTokenExpire,
        "error": error,
        "access_token_expire": accessTokenExpire,
      };
}
