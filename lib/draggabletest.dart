import 'package:flutter/material.dart';
import 'metric_card.dart';

class dragPage extends StatefulWidget {
  const dragPage({super.key});

  @override
  State<dragPage> createState() => _dragPageState();
}

class _dragPageState extends State<dragPage> {
  MetricCard bigData =
      MetricCard(metric: 'distance', value: '1', units: ' meters');
  MetricCard draggable1 =
      MetricCard(metric: 'cadence', value: '2', units: ' time/500m');
  MetricCard draggable2 =
      MetricCard(metric: 'calories', value: '3', units: ' cals');
  MetricCard draggable3 =
      MetricCard(metric: 'pace', value: '4', units: ' spm');
  MetricCard draggable4 = 
      MetricCard(metric: 'workoutTime', value: '5', units: ' sec');
  MetricCard draggable5 =
      MetricCard(metric: 'power', value: '6', units: ' watt');
  MetricCard mediumDataLeft =
      MetricCard(metric: 'strokes', value: '7', units: ' strokes');
  MetricCard mediumDataRight =
      MetricCard(metric: 'timestamp', value: '8', units: ' sec');

  MetricCard temp = MetricCard(metric: 'temp', value: '1', units: ' temp');
  MetricCard holder =
      MetricCard(metric: 'holder', value: '1', units: ' holder');

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                'Rower',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[900],
                  // fontSize: 25.0,
                ),
              ),
            ),),
        Expanded(flex: 1,child: Container(),),
        Expanded(
          flex: 2,
          child: Center(
            child: Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                Draggable(
                  data: draggable1,
                  child: draggable1,
                  feedback: Container(height: 20.0, width: 20.0, color: Colors.orange),
                  onDragStarted: () => temp = draggable1,
                  onDragCompleted: () => draggable1 = holder,
                ),
                Expanded(
                  child: Container(child:VerticalDivider(color: Colors.black,)),
                ),
                Draggable(
                  data: draggable2,
                  child: draggable2,
                  feedback: draggable2,
                  onDragStarted: () => temp = draggable2,
                  onDragCompleted: () => draggable2 = holder,
                ),
                Expanded(
                  child: Container(child:VerticalDivider(color: Colors.black,)),
                ),
                Draggable(
                  data: draggable3,
                  child: draggable3,
                  feedback: draggable3,
                  onDragStarted: () => temp = draggable3,
                  onDragCompleted: () => draggable3 = holder,
                ),
                Expanded(
                  child: Container(child:VerticalDivider(color: Colors.black,)),
                ),
                Draggable(
                  data: draggable4,
                  child: draggable4,
                  feedback: draggable4,
                  onDragStarted: () => temp = draggable4,
                  onDragCompleted: () => draggable4 = holder,
                ),
                Expanded(
                  child: Container(child:VerticalDivider(color: Colors.black,)),
                ),
                Draggable(
                  data: draggable5,
                  child: draggable5,
                  feedback: draggable5,
                  onDragStarted: () => temp = draggable5,
                  onDragCompleted: () => draggable5 = holder,
                ),
                Expanded(
                  child: Container(),
                ),
                Expanded(child: ElevatedButton(onPressed: () => print('button pressed'), child: Text('Stop')),),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
        Expanded(flex: 1,child: Container(child:Divider(color: Colors.black,)),),
        Expanded(
          flex: 6,
          child: Center(
            child: Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                DragTarget(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return mediumDataLeft;
                  },
                  onAccept: (data) {
                    setState(() {
                      holder = mediumDataLeft;
                      mediumDataLeft = temp;
                    });
                  },
                ),
                Expanded(
                  child: Container(child:VerticalDivider(color: Colors.black,)),
                ),
                DragTarget(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return bigData;
                  },
                  onAccept: (data) {
                    setState(() {
                      holder = bigData;
                      bigData = temp;
                    });
                  },
                ),
                Expanded(
                  child: Container(child:VerticalDivider(color: Colors.black,)),
                ),
                DragTarget(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return mediumDataRight;
                  },
                  onAccept: (data) {
                    setState(() {
                      holder = mediumDataRight;
                      mediumDataRight = temp;
                    });
                  },
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
