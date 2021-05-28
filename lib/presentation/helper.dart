import 'package:flutter/material.dart';

class Helper {
  static double getTextHeightRatio(
      {required double height, required double fontSize}) {
    return height / fontSize;
  }

  static Future<bool> showYesOrNoDialog(BuildContext context,
      {required String title, required String description}) async {
    bool isYes = false;

    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        isYes = true;
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

    return isYes;
  }
}
