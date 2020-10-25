import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
  static String root = "/";
  static String home = "/home/:tab";
  static String userHistory = "/history/user";
  static String myHistory = "/my/history";
  static String hisDetail = "/history/detail";
  static String twitter = "/twitter";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: rootHandler);
    router.define(home, handler: homeHandler);
    router.define(userHistory, handler: otherHistoryHandler);
    router.define(hisDetail, handler: detailHandler);
    router.define(twitter, handler: twitterHandler);

    // self
    router.define(myHistory, handler: myHistoryHandler);
  }
}
