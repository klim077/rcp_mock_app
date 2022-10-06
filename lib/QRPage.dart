import 'package:flutter/material.dart';
import 'RowerPage.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  void _openRowerPage() {
    print('Opening Rower Page');
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const RowerPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text("QRPage"),
        ElevatedButton(
          onPressed: _openRowerPage,
          child: Text("RowerPage"),
        ),
      ],
    ));
  }
}
