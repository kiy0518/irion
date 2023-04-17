//main.dart

import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';

import 'src/ble/ble_status_monitor.dart';
import 'src/screen/BleStatusPage.dart';
import 'src/service/back_service.dart';
import 'src/permission/permission.dart';
import 'src/screen/FindDevicePage.dart';
import 'src/screen/HomePage.dart';
import 'src/screen/InfoPage.dart';
import 'src/screen/SettingPage.dart';
import 'src/provider/ble_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await requestPermissions();
  await initializeService(); //NOTE - background Service initialization

  final _ble = FlutterReactiveBle();
  final _monitor = BleStatusMonitor(_ble);
  final BleStatus? status = await _monitor.status?.first;

  //NOTE - 블루투스 권한 확인하여 페이지 선
  Future<String> _getInitialRoute() async {
    if (status == BleStatus.ready) {
      return '/HomePage';
    } else {
      return '/BleStatusPage';
    }
  }

  runApp(MultiProvider(
    providers: createBleMultiProvider(_ble),
    child: MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      title: 'Lux Me App',
      debugShowCheckedModeBanner: true,
      initialRoute: await _getInitialRoute(),
      routes: {
        // '/MainPage': (context) => MainPage(),
        '/HomePage': (context) => HomePage(),
        '/FindDevicePage': (context) => FindDevicePage(),
        '/SettingPage': (context) => SettingPage(),
        '/InfoPage': (context) => InfoPage(),
        '/BleStatusPage': (context) => Consumer<BleStatus?>(
              builder: (_, status, __) {
                if (status == BleStatus.ready) {
                  return HomePage();
                } else {
                  return BleStatusPage(status: status ?? BleStatus.unknown);
                }
              },
            ),
      },
      //todo MainPage()로 이동하고 MainPage()에서 블루투스 확인해서 homepage 또는 notice 페이지로 이동하는 루틴 작성할것
      home: HomePage(),
    ),
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // drawer: _buildDrawer(context),
      body: Container(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  //TODO - 추후 추가
  // @override
  // Widget build(BuildContext context) {
  //   return Container();
  // }
}


//org
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await requestPermissions();
//   await initializeService(); //NOTE - background Service initialization

//   final _ble = FlutterReactiveBle();

//   runApp(MultiProvider(
//     providers: createBleMultiProvider(_ble),
//     child: MaterialApp(
//       title: 'Lux Me App',
//       debugShowCheckedModeBanner: true,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MainPage(),
//     ),
//   ));
// }

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int _selectedIndex = 0;

//   final List<String> _pageTitles = [
//     'Lux Mea',
//     'Find Devices',
//     'Settings',
//     'Information',
//   ];

//   final List<Widget> _pages = [
//     HomePage(),
//     FindDevicePage(),
//     SettingPage(),
//     InfoPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_pageTitles[_selectedIndex]),
//       ),
//       drawer: _buildDrawer(context),
//       body: Container(
//         child: _pages[_selectedIndex],
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }

//   Widget _buildDrawer(BuildContext context) {
//     //TODO - 블루투스 활성화 및 연결 상태 주기적으로 확인
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           const DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text(
//               'Lux Mea',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//               ),
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: const Text('Home'),
//             onTap: () {
//               setState(() {
//                 _selectedIndex = 0;
//               });
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.search),
//             title: const Text('Find Devices'),
//             onTap: () {
//               setState(() {
//                 _selectedIndex = 1;
//               });
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.settings),
//             title: const Text('Settings'),
//             onTap: () {
//               setState(() {
//                 _selectedIndex = 2;
//               });
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.info),
//             title: const Text('Information'),
//             onTap: () {
//               setState(() {
//                 _selectedIndex = 3;
//               });
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
