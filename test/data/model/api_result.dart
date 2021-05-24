import 'package:flutter_test/flutter_test.dart';
import 'package:lecture/data/model/api_result.dart';
import 'dart:convert';

void main() {
  group('Class ApiResult', () {
    test('value should start at 0', () {
      var test = ApiResult.fromJson(json.decode('{"reason":null,"status":"ok"}'));

      var ground = ApiResult(null, "ok");

      expect(test, ground);
    });
  });
}
