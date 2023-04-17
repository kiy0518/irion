import 'package:permission_handler/permission_handler.dart';

// Future<void> requestNotificationPermissions() async {
//   await Permission.notification.isDenied.then(
//     (value) {
//       if (value) {
//         Permission.notification.request();
//       }
//     },
//   );
// }
Future<bool> requestPermissions() async {
  // 블루투스, 위치, 알림 권한 요청
  Map<Permission, PermissionStatus> statuses = await [
    Permission.bluetooth,
    Permission.bluetoothScan,
    Permission.bluetoothConnect,
    Permission.locationWhenInUse,
    Permission.notification,
    Permission.bluetoothAdvertise,
  ].request();

  bool permitted = true;
  statuses.forEach((permission, permissionStatus) {
    if (!permissionStatus.isGranted) {
      permitted = false;
    }
  });

  return permitted;
}
