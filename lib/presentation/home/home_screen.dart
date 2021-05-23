import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lecture/presentation/widget/home_bottom_navbar.dart';
import 'package:lecture/symbols/color_list.dart';
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
      appBar: buildAppBar(),
      bottomNavigationBar: HomeBottomNavBar(),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
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
    );
  }

  PreferredSize buildAppBar() {
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
    return HomeLectureList();
  }

  Widget _buildFreeLecture() {
    return HomeLectureList();
  }
}
