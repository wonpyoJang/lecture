import 'package:flutter/material.dart';
import 'package:lecture/symbols/color_list.dart';

import '../helper.dart';

class LectureTotalScreen extends StatefulWidget {
  const LectureTotalScreen({Key? key}) : super(key: key);

  @override
  _LectureTotalScreenState createState() => _LectureTotalScreenState();
}

class _LectureTotalScreenState extends State<LectureTotalScreen> {
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
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: 100,
        separatorBuilder: (context, index) {
          return Container(
            height: 14.0,
          );
        },
        itemBuilder: (context, index) {
          return _buildLectureItem();
        },
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
            "무료 과목",
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

  _buildLectureItem() {
    return Container(
        height: 120,
        color: ColorList.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Image.network("https://picsum.photos/200/300",
                  width: 88, height: 88, fit: BoxFit.cover),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "캐글 문제 풀이로 배우는 데이터 분석",
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                        height:
                            Helper.getTextHeightRatio(height: 20, fontSize: 16),
                        letterSpacing: 0,
                        color: ColorList.black,
                      ),
                    ),
                    Text(
                      "유준배 선생님",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height:
                            Helper.getTextHeightRatio(height: 20, fontSize: 12),
                        letterSpacing: 0,
                        color: ColorList.lightGrey,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    _buildOfflineButton(),
                  ],
                ),
              ),
            )
          ],
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
}
