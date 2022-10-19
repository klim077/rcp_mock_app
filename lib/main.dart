import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'my_flutter_app_icons.dart' as CustomIcons;

import 'package:rcp_mock_app/RowerPage.dart';
import 'package:rcp_mock_app/draggabletest.dart';
import 'package:rcp_mock_app/metric_card.dart';
import 'QRPage.dart';
import 'button_widget.dart';
import 'smart_gym_logo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(MyApp()));
  runApp(const MyApp());
  // connectAndListen();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'RCP Rower Demo'),
      // home: RowerPage(),
      // home: RowerWidget(),
      // home: dragPage(),
      // home: MetricCard(metric: 'a', value: '3', units: 'c',goal: 3)
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _openQRPage() {
    print('Opening QR Page');
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const QRPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'RCP Demo: Rower',
      //       ),
      //       ElevatedButton(onPressed: _openQRPage, child: Text("Scan QR")),
      //       // Container(child:RowerStreamTest()),
      //     ],
      //   ),
      // ),
      body:
      Center(
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Container(),
          ),
          Flexible(
            flex: 10,
            child: Center(
                child: SmartGymLogo(
              machineType: "Rower",
            )),
          ),
          Flexible(
            flex: 2,
            child: SmartGymButtons().largeIconButton(
              onpress: _openQRPage,
              icon: CustomIcons.MyFlutterApp.qrcode,
              text: 'Scan ActiveSG QR',
            ),
          ),
          Flexible(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(flex: 1, child: Container()),
                Flexible(
                  flex: 10,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          'active_sg.png',
                          height: 70,
                          width: 140,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          'gov-tech.gif',
                          height: 70,
                          width: 140,
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 10,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'Version: 1',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 12.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(flex: 1, child: Container()),
              ],
            ),
          ),
        ],
      ),
    )
    );
  }
}
