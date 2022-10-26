import 'package:flutter/material.dart';

class SmartGymLogo extends StatefulWidget {
  final String machineType;

  SmartGymLogo({required this.machineType});

  @override
  _SmartGymLogoState createState() => _SmartGymLogoState();
}

class _SmartGymLogoState extends State<SmartGymLogo> {
  late String text;
  late String machineAsset;
  late double iconScale;

  @override
  Widget build(BuildContext context) {
    if (widget.machineType == null) {
      text = 'Please scan machine ID';
      machineAsset = 'assets/machine-icons/chest_press.png';
      iconScale = 1.3;
    } else {
      text = widget.machineType;
      if (text.contains('Rower')) {
        machineAsset = 'assets/rowingmachine.png';
        iconScale = 1.2;
      } 
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Flexible(
            flex: 7,
            child: SizedBox(
              height: 330.0,
              child: Container(
                padding: EdgeInsets.only(right: 50),
                child: Image.asset(
                  machineAsset,
                  scale: iconScale,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 8,
            child: Column(
              children: [
                Flexible(
                  flex: 4,
                  child: SizedBox(
                    height: 180.0,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        // padding: EdgeInsets.fromLTRB(0, 0, 500, 0),
                        child: Image.asset(
                          'assets/gymLogo.png',
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '$text'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
