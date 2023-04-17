import 'package:flutter/material.dart';
import 'custom_drawer.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      title: "Information",
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
            Text("여기 회사 및 제품 정보 넣을꺼임"),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';

// class InfoPage extends StatefulWidget {
//   @override
//   State<InfoPage> createState() => _InfoPageState();
// }

// class _InfoPageState extends State<InfoPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Information Page',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }
