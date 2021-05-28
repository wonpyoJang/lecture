import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lecture/data/model/course.dart';
import 'package:lecture/presentation/widget/empty_screen.dart';
import 'package:lecture/presentation/widget/home_bottom_navbar.dart';
import 'package:lecture/symbols/color_list.dart';
import 'package:lecture/symbols/screen_list.dart';
import 'home_bloc/home_bloc.dart';
import 'widget/home_lecture_list.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorList.homeBackground,
      appBar: _buildAppBar(),
      bottomNavigationBar: HomeBottomNavBar(currentScreen: ScreenList.home,),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 22.0),
            _buildRecommendedLecture(),
            SizedBox(height: 24.0),
            _buildFreeLecture(),
          ],
        ),
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Container(
          color: ColorList.white,
          child: Stack(
            children: [
              buildNotifications(),
              buildElicePurpleLogo(),
            ],
          )),
    );
  }

  Widget buildElicePurpleLogo() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          margin: const EdgeInsets.only(bottom: 7.1),
          child: Image.asset("assets/home/appbar/elice_pupple_logo.png")),
    );
  }

  Widget buildNotifications() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.only(right: 1.0, bottom: 4.0),
        width: 44,
        height: 44,
        child: Center(
          child: Container(
            width: 18,
            height: 20,
            child: SvgPicture.asset(
              "assets/home/appbar/notifications_24px.svg",
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendedLecture() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeFailure) {
          return EmptyScreen(title: "서버 연결에 실패했습니다.");
        } else if (state is HomeSuccess) {
          return _buildSuccessLectureList(state.recommendedCourses,
              isFree: false, isRecommended: true);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildFreeLecture() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeFailure) {
          return EmptyScreen(title: "서버 연결에 실패했습니다.");
        } else if (state is HomeSuccess) {
          return _buildSuccessLectureList(state.freeCourses,
              isFree: true, isRecommended: false);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildSuccessLectureList(List<Course>? courses,
      {required bool isFree, required bool isRecommended}) {
    if (courses == null) {
      return EmptyScreen(title: "강좌 목록이 없습니다.");
    } else if (courses == []) {
      return EmptyScreen(title: "강좌 목록이 없습니다.");
    } else {
      return HomeLectureList(
          courses: courses, isFree: isFree, isRecommended: isRecommended);
    }
  }
}
