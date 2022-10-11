import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MetricCard extends StatefulWidget {
  String metric;
  String value;
  String units;
  double? goal;

  MetricCard({
    required this.metric,
    required this.value,
    required this.units,
    this.goal,
  });

  @override
  State<MetricCard> createState() => _MetricCardState();
}

class _MetricCardState extends State<MetricCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration:
      //     BoxDecoration(border: Border.all(width: 2.0, color: Colors.blueGrey)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  //   child: FittedBox(
                  //     fit: BoxFit.fitHeight,
                  //     child: Text(
                  //       widget.metric.toUpperCase(),
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.blueGrey[900],
                  //         fontSize: 25.0,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          widget.metric.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[900],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: (widget.goal != null)
                        ? CircularPercentIndicator(
                          radius: 120.0,
                          lineWidth: 10.0,
                          animation: false,
                          percent: 
                          (double.parse(widget.value)/widget.goal! >= 1)
                          ?1
                          :double.parse(widget.value)/widget.goal!,
                          // percent: 1/widget.goal!,
                          center: Text(
                          widget.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 120.0,
                            fontWeight: FontWeight.normal,
                            // color: Colors.blueGrey[900],
                            color: Color.fromARGB(255, 255, 145, 0),
                          ),
                        ),
                          backgroundColor: Colors.grey,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: (double.parse(widget.value)/widget.goal! >= 1)
                          ?Colors.greenAccent
                          :Colors.redAccent,
                        )
                        
                        :Text(
                          widget.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 120.0,
                            fontWeight: FontWeight.normal,
                            // color: Colors.blueGrey[900],
                            color: Color.fromARGB(255, 255, 145, 0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          widget.units,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 120.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.blueGrey[900],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: Align(
                  //     alignment: Alignment.center,
                  //     child: FittedBox(
                  //       fit: BoxFit.fitHeight,
                  //       child: (widget.goal != null)
                  //           ? Text(
                  //               widget.goal.toString(),
                  //               // textAlign: TextAlign.center,
                  //               style: TextStyle(
                  //                 // fontSize: 45.0,
                  //                 fontWeight: FontWeight.normal,
                  //                 color: Colors.blueGrey[900],
                  //               ),
                  //           )
                  //           : Text(
                  //               widget.goal.toString(),
                  //               // textAlign: TextAlign.center,
                  //               style: TextStyle(
                  //                 // fontSize: 45.0,
                  //                 fontWeight: FontWeight.normal,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //     ),
                  //   ),
                  // ),
                ],
              ))
        ],
      ),
    );
  }
}
