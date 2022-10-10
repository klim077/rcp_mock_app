import 'package:flutter/material.dart';
import 'package:rcp_mock_app/RowerWidget.dart';
import 'package:rcp_mock_app/RowerWidget1.dart';
import 'package:rcp_mock_app/draggabletest.dart';
import 'package:rcp_mock_app/metric_card.dart';
import 'QRPage.dart';

void main() {
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
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: RowerWidget(),
      // home: dragPage(),
      home: RowerWidget1(),
      // home: MetricCard(metric: 'a', value: 'b', units: 'c',)
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'RCP Demo: Rower',
            ),
            ElevatedButton(onPressed: _openQRPage, child: Text("Scan QR")),
            // Container(child:RowerStreamTest()),
          ],
        ),
      ),
    );
  }
}
