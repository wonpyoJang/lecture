import 'package:lecture/data/model/course_response.dart';
import 'package:lecture/data/repository/course_repository.dart';

import 'base_use_case.dart';

class GetRecommendedCoursesUseCase extends BaseUseCase<CourseResponse> {
  final CourseRepository courseRepository;
  final int offset;

  GetRecommendedCoursesUseCase(this.courseRepository, {this.offset = 0});

  @override
  Future<CourseResponse> perform() {
    return courseRepository.getCourses(offset,
        filterIsFree: false, filterIsRecommended: true, count: 10);
  }
}
