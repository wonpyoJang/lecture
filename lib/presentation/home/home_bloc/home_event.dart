part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class FetchAllCoursesEvent extends HomeEvent {}

class LoadMoreFreeCoursesEvent extends HomeEvent {}

class LoadMoreRecommendedCoursesEvent extends HomeEvent {}