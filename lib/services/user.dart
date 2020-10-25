import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

///Generate MD5 hash
String generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}
