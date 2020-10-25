// format int weight: 74123 => 74.12
import 'dart:convert';

String formatIntWeight(int w) => (w / 1000).toStringAsFixed(2);

String formatJson(Map json) {
  JsonEncoder encoder = new JsonEncoder.withIndent('    ');
  return encoder.convert(json);
}
