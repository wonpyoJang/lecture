import 'package:lecture/data/model/course_response.dart';
import 'package:lecture/data/remote/course_api.dart';

import 'course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseApi courseApi;

  CourseRepositoryImpl(this.courseApi);

  @override
  Future<CourseResponse> getCourses(int offset,
      {int count = 10,
      bool filterIsFree = false,
      bool filterIsRecommended = false}) {
    return courseApi.getCourses(offset,
        count: count,
        filterIsFree: filterIsFree,
        filterIsRecommended: filterIsRecommended);
  }
}
