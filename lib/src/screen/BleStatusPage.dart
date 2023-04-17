//BleStatusPage.dart

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleStatusPage extends StatelessWidget {
  const BleStatusPage({required this.status, Key? key}) : super(key: key);

  final BleStatus status;

  String determineText(BleStatus status) {
    switch (status) {
      case BleStatus.unsupported:
        return "This device does not support Bluetooth";
      case BleStatus.unauthorized:
        return "블루투스 권한 설정이 필요합니다. 항상허용 또는 앱실행시 허용으로 설정하시기 바랍니다.";
      case BleStatus.poweredOff:
        return "블루투스가 꺼져있으니 활성화 시키세요"; //"Bluetooth is powered off on your device turn it on";
      case BleStatus.locationServicesDisabled:
        return "Enable location services";
      case BleStatus.ready:
        return "Bluetooth is up and running";
      default:
        return "Waiting to fetch Bluetooth status $status";
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Notice",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF60B4DC),
          // elevation: 5,
          // shadowColor: Colors.grey,
        ),
        body: Center(
          child: Text(
            determineText(status),
            // style: TextStyle(color: Colors.redAccent),
          ),
        ),
      );
}
