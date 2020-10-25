import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:s7_balance/screens/home/home.dart';
import 'package:s7_balance/screens/history/user_history.dart';
import 'package:s7_balance/screens/history/my_history.dart';
import 'package:s7_balance/screens/login/init.dart';
import 'package:s7_balance/screens/detail/web.dart';
import 'package:s7_balance/screens/twitters/page.dart';

var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new InitPage();
});

var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new HomeComponent(
    tabIndx: params['tab'][0],
  );
});

var twitterHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new TwitterMainPage();
});

var myHistoryHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new MyHistoryPage();
});

var otherHistoryHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new HistoryListPage(
    user: params['user'][0] ?? '',
    member: params['member'][0] ?? '',
    members: params['members'][0] ?? '',
  );
});

/// Handles deep links into the app
/// To test on Android:
///
/// `adb shell am start -W -a android.intent.action.VIEW -d "fluro://deeplink?path=/message&mesage=fluro%20rocks%21%21" com.theyakka.fluro`
var detailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {

  String pageUrl =
      'https://device.phicomm.com:5443/prod/healthy5.0/bodydetail/bodydetail.html?measureId=${params['id'][0]}&memberId=${params['member_id'][0]}&userId=${params['user_id'][0]}';
  debugPrint('pageUrl: $pageUrl');

  return new WeightDetailWebPage(pageUrl);
});
