import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lecture/presentation/helper.dart';
import 'package:lecture/symbols/color_list.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.0,
      color: ColorList.white,
      child: Row(
        children: [
          _buildHomeButton(),
          _buildQRButton(),
        ],
      ),
    );
  }

  Widget _buildHomeButton() {
    return _buildBottomNavButton(
      icon: SvgPicture.asset(
          "assets/home/bottom_navbar/account_balance_24px.svg"),
      title: "Home",
    );
  }

  Widget _buildQRButton() {
    return _buildBottomNavButton(
      icon: SvgPicture.asset("assets/home/bottom_navbar/camera_alt_24px.svg"),
      title: "QR",
    );
  }

  Expanded _buildBottomNavButton(
      {required Widget icon, required String title}) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 19,
                height: 19.3,
                child: icon,
              ),
              SizedBox(height: 5.8),
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    fontSize: 10.0,
                    height: Helper.getTextHeightRatio(height: 14, fontSize: 10),
                    letterSpacing: 0.00,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
