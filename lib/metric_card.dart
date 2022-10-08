import 'package:flutter/material.dart';

class MetricCard extends StatefulWidget {
  String metric;
  String value;
  String units;

  MetricCard({
    required this.metric,
    required this.value,
    required this.units,
  });

  @override
  State<MetricCard> createState() => _MetricCardState();
}

class _MetricCardState extends State<MetricCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
    border: Border.all(
      width: 2.0,
      color: Colors.orange)
  ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(widget.metric.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[900],
                            fontSize: 14,
                          ))),
                  Expanded(
                    flex: 3,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.value + widget.units,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.blueGrey[900],
                          ),
                        )),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
