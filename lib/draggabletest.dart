import 'package:flutter/material.dart';
import 'metric_card.dart';

class dragPage extends StatefulWidget {
  const dragPage({super.key});

  @override
  State<dragPage> createState() => _dragPageState();
}

class _dragPageState extends State<dragPage> {
  MetricCard bigdata =
      MetricCard(metric: 'distance', value: '1', units: ' meters');
  MetricCard draggable1 =
      MetricCard(metric: 'cadence', value: '2', units: ' spm');
  MetricCard draggable2 =
      MetricCard(metric: 'calories', value: '3', units: ' Cals');
  MetricCard draggable3 =
      MetricCard(metric: 'strokes', value: '4', units: ' strokes');
  MetricCard draggable4 =
      MetricCard(metric: 'pace', value: '5', units: ' spm');
  MetricCard draggable5 =
      MetricCard(metric: 'power', value: '6', units: ' watts');
  MetricCard draggable6 =
      MetricCard(metric: 'timestamp', value: '7', units: ' sec');
  MetricCard draggable7 =
      MetricCard(metric: 'workoutTime', value: '8', units: ' sec');

  MetricCard temp = MetricCard(metric: 'temp', value: '1', units: ' temp');
  MetricCard holder =
      MetricCard(metric: 'holder', value: '1', units: ' holder');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Center(child: Row(
            children: [
              Expanded(child: Container(),),
              Draggable(
                data: draggable1,
                child: draggable1,
                feedback: draggable1,
                onDragStarted: () => temp = draggable1,
                onDragCompleted: () => draggable1 = holder,
              ),
              Expanded(child: Container(),),
              Draggable(
                data: draggable2,
                child: draggable2,
                feedback: draggable2,
                onDragStarted: () => temp = draggable2,
                onDragCompleted: () => draggable2 = holder,
              ),
              Expanded(child: Container(),),
              Draggable(
                data: draggable3,
                child: draggable3,
                feedback: draggable3,
                onDragStarted: () => temp = draggable3,
                onDragCompleted: () => draggable3 = holder,
              ),
              Expanded(child: Container(),),
              Draggable(
                data: draggable4,
                child: draggable4,
                feedback: draggable4,
                onDragStarted: () => temp = draggable4,
                onDragCompleted: () => draggable4 = holder,
              ),
              Expanded(child: Container(),),
              Draggable(
                data: draggable5,
                child: draggable5,
                feedback: draggable5,
                onDragStarted: () => temp = draggable5,
                onDragCompleted: () => draggable5 = holder,
              ),
              Expanded(child: Container(),),
              Draggable(
                data: draggable6,
                child: draggable6,
                feedback: draggable6,
                onDragStarted: () => temp = draggable6,
                onDragCompleted: () => draggable6 = holder,
              ),
              Expanded(child: Container(),),
              Draggable(
                data: draggable7,
                child: draggable7,
                feedback: draggable7,
                onDragStarted: () => temp = draggable7,
                onDragCompleted: () => draggable7 = holder,
              ),
              Expanded(child: Container(),),
            ],
          ),
        ),),
        Expanded(
          flex: 2,
          child: DragTarget(
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return bigdata;
            },
            onAccept: (data) {
              setState(() {
                holder = bigdata;
                bigdata = temp;
              });
            },
          ),
        ),
      ],
    );
  }
}
