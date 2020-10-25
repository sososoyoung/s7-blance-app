import 'package:s7_balance/models/user.dart';

Map<String, dynamic> defaultUser = {
  "userId": "1111",
  "empty": false,
  "height": 175.0,
  "weight": 65.0,
  "birthday": 662688000000,
  "gender": 1,
  "nickname": "name",
  "headPictureUrl": "https://pic2.zhimg.com/v2-bfcac772f35e28c85e4af42c3ae98bfc_xll.jpg",
  "introduction": "hello",
  "refreshToken":
      "abJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImtpZCI6IjQifQ.eyJ1aWQiOiI5OTk0Njc3MCIsImNvZGUiOiJmZWl4dW4uU0hfNTIiLCJ0eXBlIjoicmVmcmVzaF90b2tlbiIsImlzcyI6IlBoaWNvbW0iLCJuYmYiOjE1NjIzODE1NDEsImV4cCI6MTU4NTcwOTU0MSwicmVmcmVzaFRpbWUiOiIyMDE5LTEwLTA0IDEwOjUyOjIxIn0.KnLTR5C3pam6p3vkXLk4U0uiLpis4Q4K7VS42mqK-2w",
  "locationCode": "",
  "country": "中国",
  "province": "北京市",
  "city": "北京市",
  "county": "朝阳区",
  "qqOpenId": null,
  "weChatOpenId": null,
  "token": "5930fc752f264989bfa7e563edd8fdb2",
  "expirationTime": 1562986341000,
  "serverTime": 1562391732616
};

Map<String, dynamic> defaultToken = {
  "access_token":
      'abJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImtpZCI6IjQifQ.eyJ1aWQiOiI5OTk0Njc3MCIsImNvZGUiOiJmZWl4dW4uU0hfNTIiLCJ0eXBlIjoicmVmcmVzaF90b2tlbiIsImlzcyI6IlBoaWNvbW0iLCJuYmYiOjE1NjUxNzY2MTUsImV4cCI6MTU4ODUwNDYxNSwicmVmcmVzaFRpbWUiOiIyMDE5LTExLTA1IDE5OjE2OjU1In0.kdE8KTs3pOX9i05hoUsIwfLGD2zUgMDp-aou8KuhWIk',
  "uid": '1111',
  "refresh_token":
      'abJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImtpZCI6IjQifQ.eyJ1aWQiOiI5OTk0Njc3MCIsImNvZGUiOiJmZWl4dW4uU0hfNTIiLCJ0eXBlIjoicmVmcmVzaF90b2tlbiIsImlzcyI6IlBoaWNvbW0iLCJuYmYiOjE1NjUxNzY2MTUsImV4cCI6MTU4ODUwNDYxNSwicmVmcmVzaFRpbWUiOiIyMDE5LTExLTA1IDE5OjE2OjU1In0.kdE8KTs3pOX9i05hoUsIwfLGD2zUgMDp-aou8KuhWIk',
  "refresh_token_expire": '23328000',
  "error": '0',
  "access_token_expire": '518400'
};

class PreferencesKeys {
  static const String user = 'conf_user';
}

class PhiStorage {
  static const String phone = '18888886666';
  getTokens() {
    return LoginTokens.fromJson(defaultToken);
  }

  getUserInfo() {
    return User.fromJson(defaultUser);
  }
}
