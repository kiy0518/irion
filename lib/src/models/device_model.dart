//device_model.dart
class DeviceModel {
  final String macid;
  final String name;
  final String temperature;
  final String battVoltage;
  final bool tempCutHistory;
  final bool battCutHistory;
  final bool lampStatus;
  final String timerValue;
  final String patternValue;

  DeviceModel(
      {required this.macid,
      required this.name,
      required this.temperature,
      required this.battVoltage,
      required this.tempCutHistory,
      required this.battCutHistory,
      required this.lampStatus,
      required this.timerValue,
      required this.patternValue});
}
