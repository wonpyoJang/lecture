import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lecture/data/model/course.dart';
import 'package:lecture/presentation/lectures_total/lectures_total_screen.dart';
import 'package:lecture/symbols/color_list.dart';
import 'package:lecture/symbols/screen_list.dart';

import '../../helper.dart';

class HomeLectureList extends StatefulWidget {
  const HomeLectureList(
      {Key? key,
      required this.courses,
      required this.isRecommended,
      required this.isFree,
      required this.title})
      : super(key: key);
  final List<Course> courses;
  final bool isRecommended;
  final bool isFree;
  final String title;

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
                itemCount: widget.courses.length,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 13.0);
                },
                itemBuilder: (context, index) {
                  return _buildLectureCardItem(item: widget.courses[index], onTap: () {
                    final snackBar = SnackBar(content: Text('${widget.courses[index].title}를 클릭하셨습니다.'), duration: Duration(seconds: 1),);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
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
          widget.title,
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
        Navigator.of(context).pushNamed(ScreenList.lecturesTotal,
            arguments: LectureTotalScreenArgument(
                isFree: widget.isFree, isRecommended: widget.isRecommended));
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

  Widget _buildLectureCardItem({required Course item, required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildCardUpperPart(item: item),
            _buildCardLowerPart(item: item),
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
      ),
    );
  }

  Widget _buildCardLowerPart({required Course item}) {
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
          // todo: 선생님 이름이 API에 존재하는지 확인.
          _buildTeacherName(teacherName:  item.numberOfInstructor()  > 0 ? item.instructors![0].fullname : "선생님 미등록"),
          SizedBox(height: 7.0),
          _buildOfflineButton()
        ],
      ),
    );
  }

  Widget _buildCardUpperPart({required Course item}) {
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
            _buildLectureImage(image: item.logoFileUrl),
            SizedBox(height: 14.0),
            _buildLectureTitle(title: item.title),
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

  Widget _buildTeacherName({required String? teacherName}) {
    return Text(
      teacherName ?? "미정",
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

  Widget _buildLectureTitle({required String? title}) {
    return Text(
      title ?? "제목 없음",
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

  Widget _buildLectureImage({required String? image}) {
    return image != null
        ? Image.network(image, width: 44, height: 44, fit: BoxFit.cover)
        : Container(width: 44, height: 44, color: Colors.grey);
  }
}
