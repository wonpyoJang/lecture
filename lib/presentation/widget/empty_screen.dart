import 'package:flutter/material.dart';

import '../helper.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 15,
              height: Helper.getTextHeightRatio(height: 20, fontSize: 15),
              letterSpacing: 0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
