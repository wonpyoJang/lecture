import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lecture/presentation/helper.dart';
import 'package:lecture/symbols/color_list.dart';
import 'package:lecture/symbols/screen_list.dart';

class HomeBottomNavBar extends StatelessWidget {
  final String currentScreen;

  const HomeBottomNavBar({Key? key, this.currentScreen = ScreenList.home})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.0,
      color: ColorList.white,
      child: Row(
        children: [
          _buildHomeButton(context),
          _buildQRButton(context),
        ],
      ),
    );
  }

  Widget _buildHomeButton(BuildContext context) {
    return _buildBottomNavButton(
        icon: SvgPicture.asset(
            "assets/home/bottom_navbar/account_balance_24px.svg"),
        iconSelected: SvgPicture.asset(
            "assets/home/bottom_navbar/account_balance_selected_24px.svg"),
        title: "Home",
        onTap: () {
          Navigator.of(context).pushReplacementNamed(ScreenList.home);
        },
        isSelected: currentScreen == ScreenList.home);
  }

  Widget _buildQRButton(BuildContext context) {
    return _buildBottomNavButton(
        icon: SvgPicture.asset("assets/home/bottom_navbar/camera_alt_24px.svg"),
        iconSelected: SvgPicture.asset(
          "assets/home/bottom_navbar/camera_alt_selected_24px.svg",
        ),
        title: "QR",
        onTap: () {
          Navigator.of(context).pushReplacementNamed(ScreenList.qr);
        },
        isSelected: currentScreen == ScreenList.qr);
  }

  Widget _buildBottomNavButton(
      {required Widget icon,
      required Widget iconSelected,
      required String title,
      required Function onTap,
      isSelected = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 19,
                  height: 19.3,
                  child: isSelected ? iconSelected : icon,
                ),
                SizedBox(height: 5.8),
                Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 10.0,
                      height:
                          Helper.getTextHeightRatio(height: 14, fontSize: 10),
                      letterSpacing: 0.00,
                      color: isSelected
                          ? ColorList.selectedPurple
                          : ColorList.unselectedGrey,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
