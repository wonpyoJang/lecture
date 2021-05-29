import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecture/data/model/course.dart';
import 'package:lecture/presentation/home/home_bloc/home_bloc.dart';
import 'package:lecture/presentation/widget/empty_screen.dart';
import 'package:lecture/symbols/color_list.dart';
import 'package:rxdart/rxdart.dart';

import '../helper.dart';

class LectureTotalScreenArgument {
  final bool isRecommended;
  final bool isFree;
  final String title;

  LectureTotalScreenArgument(
      {required this.isRecommended, required this.isFree, required this.title});
}

class LectureTotalScreen extends StatefulWidget {
  const LectureTotalScreen(
      {Key? key,
      required this.isRecommended,
      required this.isFree,
      required this.title})
      : super(key: key);
  final bool isRecommended;
  final bool isFree;
  final String title;

  @override
  _LectureTotalScreenState createState() => _LectureTotalScreenState();
}

class _LectureTotalScreenState extends State<LectureTotalScreen> {
  ScrollController? controller;
  bool isLoadCompleted = false;
  PublishSubject<bool> scrollEvents = PublishSubject<bool>();

  @override
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
    scrollEvents.stream
        .throttle((_) => TimerStream(true, Duration(seconds: 1)))
        .listen((event) {
      if (isLoadCompleted) {
        return;
      }

      if (controller!.position.extentAfter < 500) {
        if (widget.isFree) {
          BlocProvider.of<HomeBloc>(context)..add(LoadMoreFreeCoursesEvent());
        } else if (widget.isRecommended) {
          BlocProvider.of<HomeBloc>(context)
            ..add(LoadMoreRecommendedCoursesEvent());
        }
      }
    });
  }

  @override
  void dispose() {
    controller!.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    scrollEvents.add(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorList.homeBackground,
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Container(
          color: ColorList.blackBlue,
          child: Stack(
            children: [
              _buildBackButton(),
              _buildScreenTitle(),
            ],
          )),
    );
  }

  Widget _buildBackButton() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 2.0,
          ),
          width: 44,
          height: 44,
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HomeBloc>(context)..add(FetchAllCoursesEvent());
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<HomeBloc, HomeState>(
            listenWhen: (previousState, state) {
              return (previousState is HomeSuccess) && (state is HomeSuccess);
            },
            listener: (context, state) {
              final snackBar = SnackBar(
                content: Text('새로고침 되었습니다.'),
                duration: Duration(microseconds: 300),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          BlocListener<HomeBloc, HomeState>(
            listenWhen: (previousState, state) {
              return state is LoadCompleted;
            },
            listener: (context, state) {
              isLoadCompleted = true;
            },
          ),
          BlocListener<HomeBloc, HomeState>(
            listenWhen: (previousState, state) {
              return (previousState is LoadCompleted) && (state is HomeSuccess);
            },
            listener: (context, state) {
              isLoadCompleted = false;
            },
          ),
        ],
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeFailure) {
              return EmptyScreen(title: "서버 연결에 실패했습니다.");
            } else if ((state is HomeSuccess) || (state is LoadCompleted)) {
              if (widget.isFree) {
                return _buildSuccessLectureList(state.freeCourses);
              } else if (widget.isRecommended) {
                return _buildSuccessLectureList(state.recommendedCourses);
              } else {
                throw ("isFree != null || isRecommendedCourses != null should be satisfied1");
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _buildScreenTitle() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 7.1),
        width: 108,
        height: 32.9,
        child: Center(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              height: Helper.getTextHeightRatio(height: 16, fontSize: 14),
              letterSpacing: 0,
              color: ColorList.white,
            ),
          ),
        ),
      ),
    );
  }

  _buildLectureItem({required Course course}) {
    return Container(
        height: 120,
        color: ColorList.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLectureImage(image: course.logoFileUrl),
            _buildLectureInfo(course: course)
          ],
        ));
  }

  Widget _buildLectureInfo({required Course course}) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(title: course.title),
            _buildTeacherName(
                name: course.numberOfInstructor() > 0
                    ? course.instructors![0].fullname!
                    : "선생님 미등록"),
            SizedBox(height: 5.0),
            _buildOfflineButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTeacherName({required String name}) {
    return Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "Roboto",
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: Helper.getTextHeightRatio(height: 20, fontSize: 12),
        letterSpacing: 0,
        color: ColorList.lightGrey,
      ),
    );
  }

  Widget _buildTitle({required String? title}) {
    return Text(
      title ?? "제목 없음",
      textAlign: TextAlign.left,
      maxLines: 2,
      style: TextStyle(
        fontFamily: "Roboto",
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        height: Helper.getTextHeightRatio(height: 20, fontSize: 16),
        letterSpacing: 0,
        color: ColorList.black,
      ),
    );
  }

  Widget _buildLectureImage({required String? image}) {
    if (image != null) {
      return Container(
        margin: const EdgeInsets.all(16.0),
        child: Image.network(image, width: 88, height: 88, fit: BoxFit.cover),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
      );
    }
    return Container(
        margin: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 88,
          height: 88,
          child: Center(
            child: Text("이미지\n없음",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  height: Helper.getTextHeightRatio(height: 20, fontSize: 15),
                  letterSpacing: 0,
                  color: ColorList.black,
                )),
          ),
        ));
  }

  Widget _buildOfflineButton() {
    return Container(
      width: 48,
      height: 22,
      decoration: BoxDecoration(
        color: ColorList.greenBlue,
        borderRadius: BorderRadius.all(
          Radius.circular(2.0),
        ),
      ),
      child: Center(
        child: Text(
          "오프라인",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Roboto",
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            fontSize: 10,
            height: Helper.getTextHeightRatio(height: 10, fontSize: 10),
            letterSpacing: 0,
            color: ColorList.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessLectureList(
    List<Course>? courses,
  ) {
    if (courses == null) {
      return EmptyScreen(title: "강좌 목록이 없습니다.");
    } else if (courses == []) {
      return EmptyScreen(title: "강좌 목록이 없습니다.");
    } else {
      return _buildLectureList(courses: courses);
    }
  }

  Widget _buildLectureList({required List<Course> courses}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        controller: controller,
        itemCount: courses.length+1,
        separatorBuilder: (context, index) {
          return Container(
            height: 14.0,
          );
        },
        itemBuilder: (context, index) {
          if(index >= courses.length) {
            return _buildFooter();
          }
          return _buildLectureItem(course: courses[index]);
        },
      ),
    );
  }

  Widget _buildFooter() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if(state is LoadCompleted) {
          return Container(
            child: Center(
              child: Text(
                  "마지막입니다"
              ),
            ),
          );
        } else {
          return Container(
            child: Center(
              child: Text(
                  "당겨서 더 보기 +"
              ),
            ),
          );
        }
      }
    );
  }
}
