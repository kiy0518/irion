import 'package:flutter/material.dart';
import 'custom_drawer.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      title: "Settings",
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
            Text("LAMP ON TIMER 세팅 \n LAMP 점멸 패턴 선택"),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class SettingPage extends StatefulWidget {
//   @override
//   State<SettingPage> createState() => _SettingPageState();
// }

// class _SettingPageState extends State<SettingPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Settings Page',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }
