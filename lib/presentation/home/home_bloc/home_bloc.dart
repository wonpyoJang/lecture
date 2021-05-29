import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lecture/data/model/course.dart';
import 'package:lecture/data/remote/course_api_ipml.dart';
import 'package:lecture/data/repository/course_repository_impl.dart';
import 'package:lecture/domain/get_free_courses_use_case.dart';
import 'package:lecture/domain/get_recommended_courses_use_case.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(HomeInitial(
            freeCourses: null, recommendedCourses: null, hasReachedMax: false));

  late GetFreeCoursesUseCase getFreeCoursesUseCase;
  late GetRecommendedCoursesUseCase getRecommendedCoursesUseCase;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchAllCoursesEvent) {
      yield await _mapCoursesFetchedToState(state);
    }
  }

  Future<HomeState> _mapCoursesFetchedToState(HomeState state) async {
    try {
      getFreeCoursesUseCase = GetFreeCoursesUseCase(
          CourseRepositoryImpl(CourseApiImpl()),
          offset: 0);
      getRecommendedCoursesUseCase = GetRecommendedCoursesUseCase(
          CourseRepositoryImpl(CourseApiImpl()),
          offset: 0);

      final freeCourses = await getFreeCoursesUseCase.perform();
      final recommendedCourses = await getRecommendedCoursesUseCase.perform();

      return HomeSuccess(
          freeCourses: freeCourses.courses,
          recommendedCourses: recommendedCourses.courses,
          hasReachedMax: false);
      // return HomeFailure()..copyFrom(state);
    } on Exception {
      var newState = HomeFailure()..copyFrom(state);
      return newState;
    }
  }
}
