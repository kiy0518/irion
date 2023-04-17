import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import '../../screen/custom_drawer.dart';
import '../../ble/ble_device_connector.dart';
import '../../ble/ble_scanner.dart';
import '../../widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({
    required this.scannerState,
    required this.startScan,
    required this.stopScan,
    required this.toggleVerboseLogging,
    required this.verboseLogging,
    required this.bleDeviceConnector,
  });

  final BleScannerState scannerState;
  final void Function(List<Uuid>) startScan;
  final VoidCallback stopScan;
  final VoidCallback toggleVerboseLogging;
  final bool verboseLogging;
  final BleDeviceConnector bleDeviceConnector;

  @override
  DeviceListState createState() => DeviceListState();
}

// The rest of the DeviceList widget code
class DeviceListState extends State<DeviceList> {
  late TextEditingController _uuidController;
  String _savedDeviceName = '';
  String _savedDeviceId = '';

  int filterWindowSize = 100; // 이동 평균 필터 창 크기
  Map<String, List<int>> rssiFilters = {}; // 각 디바이스에 대한 이동 평균 필터
  int applyMovingAverageFilter(String deviceId, int newRssi) {
    if (!rssiFilters.containsKey(deviceId)) {
      rssiFilters[deviceId] = [];
    }

    rssiFilters[deviceId]!.add(newRssi);

    if (rssiFilters[deviceId]!.length > filterWindowSize) {
      rssiFilters[deviceId]!.removeAt(0);
    }

    int sum = rssiFilters[deviceId]!.reduce((a, b) => a + b);
    return sum ~/ rssiFilters[deviceId]!.length;
  }

  @override
  void initState() {
    super.initState();
    _uuidController = TextEditingController()
      ..addListener(() => setState(() {}));
    _loadSavedDeviceInfo(); // 이 부분을 추가합니다.
  }

  @override
  void dispose() {
    widget.stopScan();
    _uuidController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedDeviceInfo() async {
    _savedDeviceName = await _getSavedDeviceName();
    _savedDeviceId = await _getSavedDeviceId();
    setState(() {});
  }

  Future<String> _getSavedDeviceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('savedDeviceId') ?? '';
  }

  Future<void> _saveDeviceId(String deviceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedDeviceId', deviceId);
    print('Saved device ID: $deviceId');
  }

  Future<String> _getSavedDeviceName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('savedDeviceName') ?? '';
  }

  Future<void> _saveDeviceName(String deviceName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedDeviceName', deviceName);
    print('Saved device name: $deviceName');
  }

  bool _isValidUuidInput() {
    final uuidText = _uuidController.text;
    if (uuidText.isEmpty) {
      return true;
    } else {
      try {
        Uuid.parse(uuidText);
        return true;
      } on Exception {
        return false;
      }
    }
  }

  void _startScanning() {
    final text = _uuidController.text;
    widget.startScan(text.isEmpty ? [] : [Uuid.parse(_uuidController.text)]);
  }

  Future<void> _disconnectAndremoveSavedDeviceInfo() async {
    if (_savedDeviceId.isNotEmpty) {
      // Disconnect the connected device
      await widget.bleDeviceConnector.disconnect(_savedDeviceId);
      _startScanning();
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('savedDeviceId');
    await prefs.remove('savedDeviceName');
    print('Removed saved device info');
    _savedDeviceId = '';
    _savedDeviceName = '';
    setState(() {});
  }

  Future<void> _connect() async {
    //todo 연결이 끊어졌는지 확인
    // Connect the connected device
    // final service = FlutterBackgroundService();
    // await _channel.invokeMethod('connectToDevice', _savedDeviceId);
    await widget.bleDeviceConnector.connect(_savedDeviceId);

    setState(() {});
  }

  void _removeDeviceOfList(DiscoveredDevice device) async {
    await widget.scannerState.discoveredDevices.remove(device);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Sort devices by 'Lux Mea' devices first
    final sortedDevices = widget.scannerState.discoveredDevices.toList()
      ..sort((a, b) {
        if (a.name.startsWith('Lux Mea') && !b.name.startsWith('Lux Mea')) {
          return -1;
        } else if (!a.name.startsWith('Lux Mea') &&
            b.name.startsWith('Lux Mea')) {
          return 1;
        } else {
          return 0;
        }
      });

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9887FE), Color(0xFF60B4DC)],
            stops: [0, 0.5],
            begin: AlignmentDirectional(1, 1),
            end: AlignmentDirectional(-1, -1),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text("등록된 장치"),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_savedDeviceName.isNotEmpty
                          ? '$_savedDeviceName: $_savedDeviceId'
                          : '등록된 장치 없음'),
                      if (_savedDeviceName.isNotEmpty)
                        ElevatedButton(
                          onPressed: _disconnectAndremoveSavedDeviceInfo,
                          child: const Text('등록 해제'),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: !widget.scannerState.scanIsInProgress &&
                                _isValidUuidInput()
                            ? _startScanning
                            : null,
                        child: const Text('Scan'),
                      ),
                      ElevatedButton(
                        onPressed: widget.scannerState.scanIsInProgress
                            ? widget.stopScan
                            : null,
                        child: const Text('Stop'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView(
                children: [
                  ...sortedDevices.map(
                    (device) {
                      int filteredRssi = applyMovingAverageFilter(
                          device.id.toString(), device.rssi);

                      return ListTile(
                        title: Text(
                          device.name,
                          style: device.name.startsWith('Lux Mea')
                              ? TextStyle(fontWeight: FontWeight.bold)
                              : null,
                        ),
                        subtitle: Text("${device.id}\nRSSI: $filteredRssi"),
                        leading: device.name.startsWith('Lux Mea')
                            ? const Icon(Icons.bluetooth, color: Colors.blue)
                            : const BluetoothIcon(),
                        onTap: () async {
                          // Save device ID and name if not saved yet
                          if (_savedDeviceId.isEmpty) {
                            await _saveDeviceId(device.id.toString());
                            await _saveDeviceName(device.name.toString());
                            // Update saved device ID and name in the state
                            _savedDeviceId = device.id.toString();
                            _savedDeviceName = device.name.toString();
                          }
                          await _connect();
                          widget.stopScan();
                          _removeDeviceOfList(device);

                          // Navigator.popAndPushNamed(context, 'Home');

                          // await Navigator.push<void>(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) =>
                          //             DeviceDetailScreen(device: device)));
                          // Print saved device ID after returning from the DeviceDetailScreen
                          print('Saved device ID: $_savedDeviceId');
                        },
                      );
                    },
                  ).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
