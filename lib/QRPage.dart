import 'dart:convert';

import 'package:flutter/material.dart';
import 'RowerPage.dart';
import 'config.dart';
import 'openapi_client.dart';



class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  static const userID = "123456";
  static const machineID = "cd44558bb2454746a9a7c6b8c1fd4716";

  final OpenApiClient openApiClient = OpenApiClient();

  void _openRowerPage() async {
        // Clear redis and initialize with new user
    String method = 'machines/$machineID/initializeRowerWithUser';
    print(method);

    final response =
        await openApiClient.post(
          endPoint: '$backendIP:22090', 
          method: method, 
          body: {"value":userID});
    print('Response Body: ${response.body}');
    var res = json.decode(response.body);

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

