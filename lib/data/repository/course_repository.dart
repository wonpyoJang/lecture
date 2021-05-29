import 'package:lecture/data/model/course_response.dart';

abstract class CourseRepository {
  Future<CourseResponse> getCourses(int offset,
      {int count = 10,
      bool filterIsFree = false,
      bool filterIsRecommended = false,});
}
