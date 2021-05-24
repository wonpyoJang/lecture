import 'package:lecture/data/model/course_response.dart';

abstract class CourseApi {
  Future<CourseResponse> getCourses(int offset, {int count = 10, bool filterIsFree = false, bool filterIsRecommended = false});
}