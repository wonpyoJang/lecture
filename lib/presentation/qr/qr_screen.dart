import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lecture/presentation/widget/home_bottom_navbar.dart';
import 'package:lecture/symbols/color_list.dart';
import 'package:lecture/symbols/screen_list.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';

import '../helper.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isDialogOn = false;
  bool isCameraPermissionAllowed = false;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  void checkPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      final snackBar = SnackBar(content: Text('유효한 url이 아닙니다.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (await Permission.location.isRestricted) {
      final snackBar = SnackBar(content: Text('유효한 url이 아닙니다.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    isCameraPermissionAllowed = true;
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.yellow,
          borderRadius: 0,
          borderLength: 114,
          borderWidth: 2,
          cutOutSize: 220),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream
        .throttle((_) => TimerStream(true, Duration(seconds: 2)))
        .listen((scanData) async {
      if (isDialogOn == true) {
        return;
      }
      isDialogOn = true;

      String decoded = "";

      if (scanData.code.startsWith("http")) {
        decoded = scanData.code;
      } else {
        try {
          decoded = utf8.decode(base64Url.decode(scanData.code));
        } catch(error) {
          final snackBar = SnackBar(content: Text('유효한 url이 아닙니다.\n $error'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        }
      }

      var isAcceptedByUser = await Helper.showYesOrNoDialog(
        context,
        title: "Url로 이동",
        description: "다음 Url로 이동하시겠습니까?\n\n $decoded",
      );

      if (isAcceptedByUser) {
        await Navigator.of(context)
            .pushNamed(ScreenList.webView, arguments: decoded);
      }
      isDialogOn = false;

    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
      bottomNavigationBar: HomeBottomNavBar(currentScreen: ScreenList.qr,),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
        child: Container(
          color: Colors.white,
          height: 80,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 7.1),
              height: 32.9,
              child: Center(
                child: Text("QR",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: Helper.getTextHeightRatio(height: 14, fontSize: 16),
                      letterSpacing: 0,
                      color: ColorList.black,
                    )),
              ),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(60),);
  }
}
