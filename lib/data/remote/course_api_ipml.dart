import 'package:lecture/data/model/course_response.dart';
import 'package:http/http.dart' as http;
import 'course_api.dart';
import 'dart:convert';

class CourseApiImpl implements CourseApi {
  @override
  Future<CourseResponse> getCourses(int offset,
      {int count = 10,
      bool filterIsFree = false,
      bool filterIsRecommended = false}) async {
    try {
      var queryParameters = {
        'filter_is_free': filterIsFree.toString(),
        'filter_is_recommended': filterIsRecommended.toString(),
        'offset': offset.toString(),
        'count': count.toString(),
      };

      Uri uri = Uri.https(
          'api-rest.elice.io', "/org/academy/course/list/", queryParameters);

      print("[API call]" + uri.toString());

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> mapResponse = json.decode(response.body);

        return CourseResponse.fromJson(mapResponse);
      } else {
        throw Exception("Error Code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("get now playing movie is failed!");
    }
  }
}
