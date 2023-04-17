//FindDevicePage.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_drawer.dart';
import '../widgets/widgets.dart';
import '../ble/ble_device_connector.dart';
import '../ble/ble_logger.dart';
import '../ble/ble_scanner.dart';
import '../ui/device_detail/device_list.dart'; // Import the new file here

const _channel =
    const MethodChannel('com.example.luxmea_v202/background_service');

class FindDevicePage extends StatefulWidget {
  const FindDevicePage({Key? key}) : super(key: key);

  @override
  State<FindDevicePage> createState() => _FindDevicePageState();
}

class _FindDevicePageState extends State<FindDevicePage> {
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      title: "Find Device",
      child: Consumer4<BleScanner, BleScannerState?, BleLogger,
          BleDeviceConnector>(
        builder: (_, bleScanner, bleScannerState, bleLogger, bleDeviceConnector,
                __) =>
            DeviceList(
          scannerState: bleScannerState ??
              const BleScannerState(
                discoveredDevices: [],
                scanIsInProgress: false,
              ),
          startScan: bleScanner.startScan,
          stopScan: bleScanner.stopScan,
          toggleVerboseLogging: bleLogger.toggleVerboseLogging,
          verboseLogging: bleLogger.verboseLogging,
          bleDeviceConnector: bleDeviceConnector,
        ),
      ),
    );
  }
}
