part of 'home_bloc.dart';

@immutable
class HomeState {
  final List<Course>? freeCourses;
  final List<Course>? recommendedCourses;
  final bool? hasReachedMax;

  HomeState(
      {this.freeCourses, this.recommendedCourses, this.hasReachedMax = false});

  HomeState copyWith(
      {List<Course>? freeCourses,
      List<Course>? recommendedCourses,
      bool? hasReachedMax}) {
    return HomeState(
        freeCourses: freeCourses ?? this.freeCourses,
        recommendedCourses: recommendedCourses ?? this.recommendedCourses,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  HomeState copyFrom(HomeState state) {
    return HomeState(
        freeCourses: state.freeCourses ?? this.freeCourses,
        recommendedCourses: state.recommendedCourses ?? this.recommendedCourses,
        hasReachedMax: state.hasReachedMax ?? this.hasReachedMax);
  }
}

class HomeInitial extends HomeState {
  HomeInitial(
      {List<Course>? freeCourses,
      List<Course>? recommendedCourses,
      bool? hasReachedMax})
      : super(
            freeCourses: freeCourses,
            recommendedCourses: recommendedCourses,
            hasReachedMax: hasReachedMax);
}

class HomeSuccess extends HomeState {
  HomeSuccess(
      {List<Course>? freeCourses,
      List<Course>? recommendedCourses,
      bool? hasReachedMax})
      : super(
            freeCourses: freeCourses,
            recommendedCourses: recommendedCourses,
            hasReachedMax: hasReachedMax);
}

class HomeFailure extends HomeState {
  HomeFailure(
      {List<Course>? freeCourses,
      List<Course>? recommendedCourses,
      bool? hasReachedMax})
      : super(
            freeCourses: freeCourses,
            recommendedCourses: recommendedCourses,
            hasReachedMax: hasReachedMax);
}

class LoadCompleted extends HomeState {
  LoadCompleted(
      {List<Course>? freeCourses,
        List<Course>? recommendedCourses,
        bool? hasReachedMax})
      : super(
      freeCourses: freeCourses,
      recommendedCourses: recommendedCourses,
      hasReachedMax: hasReachedMax);
}

