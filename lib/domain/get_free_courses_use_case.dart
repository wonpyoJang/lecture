import 'package:lecture/data/model/course_response.dart';
import 'package:lecture/data/repository/course_repository.dart';

import 'base_use_case.dart';

class GetFreeCoursesUseCase extends BaseUseCase<CourseResponse> {
  final CourseRepository courseRepository;
  final int offset;

  GetFreeCoursesUseCase(this.courseRepository, {this.offset = 0});

  @override
  Future<CourseResponse> perform() {
    return courseRepository.getCourses(offset,
        filterIsFree: true, filterIsRecommended: false, count: 10);
  }
}
