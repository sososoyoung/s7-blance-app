import 'package:flutter/material.dart';

class PagePrint {
  final String page;

  PagePrint(this.page);
  debug(String msg) {
    debugPrint('[page:$page] $msg');
  }
}
