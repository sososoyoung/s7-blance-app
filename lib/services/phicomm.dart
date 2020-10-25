import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:s7_balance/config/consts.dart';
import 'package:s7_balance/utils/ts_key.dart';
import 'package:s7_balance/models/apis.dart';
import 'package:s7_balance/models/user.dart';

class PhiApi {
  final String userId;
  final String token;

  PhiApi({this.userId, this.token});

  static BaseOptions deviceOpt = new BaseOptions(
    baseUrl: ApiConfig.balanceUrl,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );

  static BaseOptions accOpt = new BaseOptions(
    baseUrl: ApiConfig.accountUrl,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );

  static BaseOptions momentsOpt = new BaseOptions(
    baseUrl: ApiConfig.momentsUrl,
    connectTimeout: 15000,
    receiveTimeout: 15000,
  );

  Dio acc = new Dio(accOpt);
  Dio device = new Dio(deviceOpt);
  Dio moments = new Dio(momentsOpt);

  /// ************
  /// accounts APis
  /// ************

  Future<User> getUserBasicInfo() async {
    this.acc.options.headers = makeHeaders();
    Response response = await this.acc.post("/home/page/data/get",
        data: {"appId": "balance", "userId": this.userId});
    User info = User.fromJson(response.data['data']);
    return info;
  }

  Future<User> getUserBasicInfoWithAccessToken(String refreshToken,
      String accessToken, String phone, String userId) async {
    int ts = DateTime.now().millisecondsSinceEpoch;
    int phicommKey = phiTsToKey(ts);
    this.acc.options.headers = {
      'Accept-Encoding': 'gzip',
      'User-Agent': 'okhttp/3.4.1',
      'Phicomm-Timestamp': ts,
      'Phicomm-Key': phicommKey,
      'Phicomm-AppId': 'balance',
      'Phicomm-Platform': 'android',
      'Phicomm-Channel': '0QHU',
      'Phicomm-AppVersion': '5.2.3031.0',
    };
    Response response = await this.acc.post("/phone/login", data: {
      "appId": "balance",
      "userId": userId,
      "deviceId": 'Aj17wuKrx9H6CDyYGsNOKgj4C_ZOxrRpq0DaQ0ekyL4A',
      "phicommUnionToken": accessToken,
      "phoneNumber": phone,
      "refreshToken": refreshToken
    });
    User info = User.fromJson(response.data['data']);
    return info;
  }

  /// ************
  /// Device APis
  /// ************
  makeHeaders() {
    int ts = DateTime.now().millisecondsSinceEpoch;
    int phicommKey = phiTsToKey(ts);
    return {
      'Accept-Encoding': 'gzip',
      'User-Agent': 'okhttp/3.4.1',
      'Phicomm-Timestamp': ts,
      'Phicomm-Key': phicommKey,
      'Phicomm-AppId': 'balance',
      'Phicomm-Platform': 'android',
      'Phicomm-Channel': '0QHU',
      'Phicomm-AppVersion': '5.2.3031.0',
      'Phicomm-Token': this.token,
      'Phicomm-UserId': this.userId
    };
  }

  makeHeadersWithUid(String uid) {
    int ts = DateTime.now().millisecondsSinceEpoch;
    int phicommKey = phiTsToKey(ts);
    return {
      'Accept-Encoding': 'gzip',
      'User-Agent': 'okhttp/3.4.1',
      'Phicomm-Timestamp': ts,
      'Phicomm-Key': phicommKey,
      'Phicomm-AppId': 'balance',
      'Phicomm-Platform': 'android',
      'Phicomm-Channel': '0QHU',
      'Phicomm-AppVersion': '5.2.3031.0',
      'Phicomm-UserId': uid
    };
  }

  Future<List<WeightHistory>> getRecentHistory(
    int memberId,
  ) async {
    Response response = await this.device.post("/home/page/data/get",
        options: Options(
          headers: makeHeaders(),
        ),
        data: {"memberId": memberId});
    List<WeightHistory> result = [];
    response.data['data'].forEach((data) {
      result.add(WeightHistory.fromJson(data));
    });
    result.sort((a, b) => b.createTime.compareTo(a.createTime));
    return result;
  }

  Future<List<WeightHistory>> getRecentHistoryByUid(
      int memberId, String uid) async {
    Response response = await this.device.post("/home/page/data/get",
        options: Options(
          headers: makeHeadersWithUid(uid),
        ),
        data: {"memberId": memberId});
    List<WeightHistory> result = [];
    response.data['data'].forEach((data) {
      result.add(WeightHistory.fromJson(data));
    });
    result.sort((a, b) => b.createTime.compareTo(a.createTime));
    return result;
  }

  getWeightDetail(int memberId, int measureId) async {
    Response res = await this.device.get(
          "/h5/data/body/detail/v2?memberId=$memberId&measureId=$measureId",
          options: Options(
            headers: makeHeaders(),
          ),
        );
    return res;
  }

  Future<List<UserMember>> getMembers() async {
    Response response = await this.device.post("/balance/member/list",
        data: {"userId": this.userId},
        options: Options(
          headers: makeHeaders(),
        ));
    List<UserMember> members = [];
    for (var m in response.data['data']) {
      members.add(UserMember.fromJson(m));
    }
    return members;
  }

  Future<List<UserMember>> getMembersByUid(String uid) async {
    Response response = await this.device.post("/balance/member/list",
        data: {"userId": uid},
        options: Options(
          headers: makeHeadersWithUid(uid),
        ));
    List<UserMember> members = [];
    for (var m in response.data['data']) {
      members.add(UserMember.fromJson(m));
    }
    return members;
  }

  // 上此数据 id
  Future<int> getMaxMeasureId(int memberId) async {
    Response response = await this.device.post("/balance/max/measure/id/get",
        options: Options(
          headers: makeHeaders(),
        ),
        data: {"memberId": memberId.toString()});
    int measureId = response.data['data'];
    return measureId;
  }

  // 上锁
  Future<bool> lock(int memberId) async {
    Response response = await this.device.post("/balance/lock",
        options: Options(
          headers: makeHeaders(),
        ),
        data: {"memberId": memberId.toString()});
    debugPrint('lock: ${response.data}');
    bool isLocked = response.data['data']['lock'];
    return isLocked;
  }

  // 解锁
  Future<bool> unLock(int memberId) async {
    Response response = await this.device.post("/balance/unlock",
        options: Options(
          headers: makeHeaders(),
        ),
        data: {"memberId": memberId.toString()});
    debugPrint('unlock: ${response.data}');
    bool isUnLocked = response.data['status'] == 0;
    return isUnLocked;
  }

  // 最新称重数据
  Future<NewWeightRes> checkWeight(int memberId, int measureId) async {
    Response response = await this.device.post("/balance/v2/claim/data/check",
        options: Options(
          headers: makeHeaders(),
        ),
        data: {
          "memberId": memberId.toString(),
          "measureId": measureId.toString()
        });

    debugPrint('checkWeight res: ${response.data['data']}');
    Map data = response.data['data'];

    return NewWeightRes.fromJson(data);
  }

  // 待认领
  Future<List<ClaimWeight>> getClaimWeight(int memberId) async {
    Response response = await this.device.post("/balance/claim/data/get",
        options: Options(
          headers: makeHeaders(),
        ),
        data: {"memberId": memberId});
    List<ClaimWeight> result = [];
    response.data['data'].forEach((data) {
      result.add(ClaimWeight.fromJson(data));
    });
    result.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return result;
  }

  // 认领
  Future<int> ownClaimWeight(int memberId, int rawDataId) async {
    Response response = await this.device.post("/balance/claim/data/own",
        options: Options(
          headers: makeHeaders(),
        ),
        data: {"memberId": memberId, 'rawDataId': rawDataId});
    int status = response.data['status'];
    return status;
  }

  Future<List<Twitter>> getTweets(
      {String category, int count, String maxId}) async {
    // https://device.phicomm.com:8443/moments/api/v1/tweet?category=latest&count=20&max_id=6545248427477831680&show_link=
    String url = "/tweet?category=$category&count=$count&show_link=true";
    if (maxId.isNotEmpty) {
      url += '&max_id=$maxId';
    }

    Response response = await this.moments.get(
          url,
          options: Options(
            headers: makeHeaders(),
          ),
        );

    debugPrint('getTweets:');
    // debugPrint(response.data);
    return new List<Twitter>.from(
        response.data['result'].map((x) => Twitter.fromJson(x)));
  }
}
