import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lecture/symbols/color_list.dart';
import 'package:lecture/symbols/screen_list.dart';

import '../../helper.dart';

class HomeLectureList extends StatefulWidget {
  const HomeLectureList({Key? key}) : super(key: key);

  @override
  _HomeLectureListState createState() => _HomeLectureListState();
}

class _HomeLectureListState extends State<HomeLectureList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 231,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTitle(),
              _buildShowTotal(),
            ],
          ),
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.only(left: 16.0, top: 11.0),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 100,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 13.0);
                },
                itemBuilder: (context, index) {
                  return _buildLectureCardItem();
                }),
          )
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Center(
        child: Text(
          "추천과목",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Roboto",
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            height: Helper.getTextHeightRatio(height: 12, fontSize: 17),
            letterSpacing: 0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildShowTotal() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ScreenList.lecturesTotal);
      },
      child: Container(
        padding: const EdgeInsets.only(right: 16.0),
        child: Center(
          child: Text(
            "전체 보기",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              fontSize: 10,
              height: Helper.getTextHeightRatio(height: 14, fontSize: 10),
              letterSpacing: 0,
              color: ColorList.deepBlue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLectureCardItem() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildCardUpperPart(),
          _buildCardLowerPart(),
        ],
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 1,
          offset: Offset(-2, -3), // changes position of shadow
        ),
      ]),
    );
  }

  Widget _buildCardLowerPart() {
    return Container(
      width: 160,
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: ColorList.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(7.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          _buildTeacherName(),
          SizedBox(height: 7.0),
          _buildOfflineButton()
        ],
      ),
    );
  }

  Widget _buildCardUpperPart() {
    return Container(
      width: 160,
      height: 136,
      decoration: BoxDecoration(
        color: ColorList.lightBlue,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(7.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            SizedBox(
              height: 17,
            ),
            buildLectureImage(),
            SizedBox(height: 14.0),
            _buildLectureTitle(),
          ],
        ),
      ),
    );
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

  Widget _buildTeacherName() {
    return Text(
      "유준배 선생님",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "Roboto",
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: Helper.getTextHeightRatio(height: 20, fontSize: 12),
        letterSpacing: 0,
        color: ColorList.grey,
      ),
    );
  }

  Widget _buildLectureTitle() {
    return Text(
      "캐글 문제 풀이로 배우는 데이터 분석",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "Roboto",
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        height: Helper.getTextHeightRatio(height: 20, fontSize: 16),
        letterSpacing: 0,
        color: ColorList.white,
      ),
    );
  }

  Widget buildLectureImage() {
    return Image.network("https://picsum.photos/200/300",
        width: 44, height: 44, fit: BoxFit.cover);
  }
}
