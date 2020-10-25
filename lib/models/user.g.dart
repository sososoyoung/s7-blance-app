// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      userId: json['userId'] as String,
      empty: json['empty'] as bool,
      height: (json['height'] as num)?.toDouble(),
      weight: (json['weight'] as num)?.toDouble(),
      birthday: json['birthday'] as int,
      gender: json['gender'] as int,
      nickname: json['nickname'] as String,
      headPictureUrl: json['headPictureUrl'] as String,
      introduction: json['introduction'] as String,
      refreshToken: json['refreshToken'] as String,
      locationCode: json['locationCode'] as String,
      country: json['country'] as String,
      province: json['province'] as String,
      city: json['city'] as String,
      county: json['county'] as String,
      qqOpenId: json['qqOpenId'],
      weChatOpenId: json['weChatOpenId'],
      token: json['token'] as String,
      expirationTime: json['expirationTime'] as int,
      serverTime: json['serverTime'] as int);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'empty': instance.empty,
      'height': instance.height,
      'weight': instance.weight,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'nickname': instance.nickname,
      'headPictureUrl': instance.headPictureUrl,
      'introduction': instance.introduction,
      'refreshToken': instance.refreshToken,
      'locationCode': instance.locationCode,
      'country': instance.country,
      'province': instance.province,
      'city': instance.city,
      'county': instance.county,
      'qqOpenId': instance.qqOpenId,
      'weChatOpenId': instance.weChatOpenId,
      'token': instance.token,
      'expirationTime': instance.expirationTime,
      'serverTime': instance.serverTime
    };
