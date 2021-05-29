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
      yield await _mapFetchAllCoursesToState(state);
    } else if(event is LoadMoreFreeCoursesEvent) {
      yield await _mapLoadMoreFreeCourseToState(state);
    } else if (event is LoadMoreRecommendedCoursesEvent) {
      yield await _mapLoadMoreRecommendedCourseToState(state);
    }
  }

  Future<HomeState> _mapFetchAllCoursesToState(HomeState state) async {
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
    } on Exception {
      var newState = HomeFailure()..copyFrom(state);
      return newState;
    }
  }

  Future<HomeState> _mapLoadMoreFreeCourseToState(HomeState state) async{
    try {
      getFreeCoursesUseCase = GetFreeCoursesUseCase(
          CourseRepositoryImpl(CourseApiImpl()),
          offset: state.freeCourses?.length ?? 0);

      var result = await getFreeCoursesUseCase.perform();

      List<Course> previousFreeCourses = state.freeCourses ?? [];
      List<Course> newCorses = result.courses ?? [];
      List<Course> totalFreeCourses = [...previousFreeCourses, ...newCorses];


      if(totalFreeCourses.length >= result.courseCount!) {
        return LoadCompleted(
            freeCourses: totalFreeCourses,
            recommendedCourses: state.recommendedCourses,
            hasReachedMax: false);
      } else {
        return HomeSuccess(
            freeCourses: totalFreeCourses,
            recommendedCourses: state.recommendedCourses,
            hasReachedMax: false);
      }
    } on Exception {
      var newState = HomeFailure()..copyFrom(state);
      return newState;
    }
  }

  Future<HomeState> _mapLoadMoreRecommendedCourseToState(HomeState state) async{
    try {
      getRecommendedCoursesUseCase = GetRecommendedCoursesUseCase(
          CourseRepositoryImpl(CourseApiImpl()),
          offset: state.recommendedCourses?.length ?? 0);

      var result = await getRecommendedCoursesUseCase.perform();

      List<Course> previousRecommendedCourses = state.recommendedCourses ?? [];
      List<Course> newCourses = result.courses ?? [];
      List<Course> totalRecommendedCourses = [...previousRecommendedCourses, ...newCourses];

      if(totalRecommendedCourses.length >= result.courseCount!) {
        return LoadCompleted(
            freeCourses: state.freeCourses,
            recommendedCourses: totalRecommendedCourses,
            hasReachedMax: false);
      } else {
        return HomeSuccess(
            freeCourses: state.freeCourses,
            recommendedCourses: totalRecommendedCourses,
            hasReachedMax: false);
      }
    } on Exception {
      var newState = HomeFailure()..copyFrom(state);
      return newState;
    }
  }
}
