// HomePage.dart
import 'package:flutter/material.dart';
import 'custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      title: "Lux Mea",
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
        child: Padding(
          padding: EdgeInsets.only(bottom: 50),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Add this line to align the Stack to the bottom of the screen

                children: [
                  Padding(
                    //NOTE - 상단 제품 이미지
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/SIZE_CHANGE01.png',
                        // width: MediaQuery.of(context).size.width * 1,
                        width: 280,
                        height: 169,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 30, 16, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 310,
                            width: double.infinity,
                            color: Color(0xFF30383F),
                          ),
                        ),
                      ),
                      Padding(
                        //NOTE - 센터 LAMP ON / OFF 스위치
                        padding: const EdgeInsets.only(top: 10),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Container(
                              color: Color(0xFF30383F),
                              height: 110,
                              width: 110,
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    // color: Colors.amber[700],
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF60B4DC),
                                          Color(0xFF9887FE)
                                        ],
                                        stops: [0.5, 1],
                                        begin: AlignmentDirectional(1, 1),
                                        end: AlignmentDirectional(-1, -1),
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.power_settings_new_rounded,
                                        opticalSize:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                      color: Colors.white,

                                      onPressed:
                                          () {}, //TODO - LAMP 전원 ON/OFF 스위치 동작
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        //NOTE - 센터 Connect 인디게이터
                        padding: EdgeInsets.fromLTRB(16, 120, 16, 0),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.black38, //Color(0xFF30383F)
                              height: 30,
                              width: 100,
                              child: Text(
                                "Connected", //TODO - 연결상태에 따라 변경
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 160, 30, 0),
                          child: Container(
                            // height: 150,
                            width: double.infinity,
                            color: Color(0xFF30383F),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: double.infinity,
                                    height: 35,
                                    color: Colors.white,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Icons.bluetooth,
                                          ),
                                          Text("블루투스 상태  Bluetooth"),
                                          Text("Good"), //TODO - 연결상태에 따라 변경
                                          Icon(Icons.signal_cellular_alt)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: double.infinity,
                                    height: 35,
                                    color: Colors.white,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Icons
                                                .battery_charging_full_outlined,
                                          ),
                                          Text("배터리 상태  Battery"),
                                          Text("Good"), //TODO - 값에 따라 변경
                                          Icon(Icons.signal_cellular_alt)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: double.infinity,
                                    height: 35,
                                    color: Colors.white,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.thermostat_sharp,
                                          ),
                                          Text("제품 온도  Temperature"),
                                          Text("Good"), //TODO - 값에 따라 변경
                                          Icon(Icons.signal_cellular_alt)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 5, 0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.error_outline,
                                            color: Colors.white),
                                      ),
                                      Expanded(
                                        child: Text(
                                          " 과열로 인한 화재의 징후가 있을시 전원이 자동 차단됩니다.", // TODO 차단메시지
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
