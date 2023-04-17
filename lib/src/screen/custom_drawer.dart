// custom_drawer.dart
import 'package:flutter/material.dart';
import 'FindDevicePage.dart';
import 'SettingPage.dart';
import 'HomePage.dart';
import 'InfoPage.dart';

class CustomDrawer extends StatelessWidget {
  final Widget child;
  final String title;

  CustomDrawer({required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF60B4DC),
        // elevation: 5,
        // shadowColor: Colors.grey,
      ),
      body: child,
      drawer: Drawer(
        width: 250,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                  decoration: BoxDecoration(color: Color(0xFF60B4DC)),
                  child: Column(
                    children: [
                      Text('Lux Mea'),
                      Text('여기에 이미지'),
                    ],
                  )),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the drawer
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()));
                  // Navigator.of(context).pushReplacementNamed('/HomePage');
                },
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Find Device'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the drawer
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FindDevicePage()));
                  // Navigator.of(context).pushReplacementNamed('/FindDevicePage');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Setting'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the drawer
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingPage()));
                  // Navigator.of(context).pushReplacementNamed('/SettingPage');
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Information'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the drawer
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => InfoPage()));
                  // Navigator.of(context).pushReplacementNamed('/InfoPage');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
