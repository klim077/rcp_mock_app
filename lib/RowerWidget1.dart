import 'dart:convert';
import 'dart:html';
import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:socket_io_client/socket_io_client.dart';
import 'config.dart';
import 'metric_card.dart';
import 'openapi_client.dart';
import 'rower_model.dart';

// This helps with the streaming of data
class StreamSocket {
  final _socketResponse = StreamController<Rower>();

  void Function(Rower) get addResponse => _socketResponse.sink.add;

  Stream<Rower> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

StreamSocket streamSocket = StreamSocket();

// Function that connects and listens to socketio
void connectAndListen() {
  // Init and connects socketio
  IO.Socket socket = IO.io('$backendURL', {
    'path': '/socket.io/',
    'autoConnect': false,
    'transports': ['websocket']
  });
  socket.connect();

  // Instantiate openapiclient
  final OpenApiClient openApiClient = OpenApiClient();

  // Function that gets called when received 'connect' message
  // Emits "channel" back to socketio server to get socketio server to subscribe to
  // this channel on redis
  // socketio server will then get notified when redis is updated
  socket.on('connect', (_) {
    print('Connected');
    var channel = '{ "channel" : "123456" }';
    socket.emit('mobileConnected', channel);
    print('emitted: $channel');
  });

  // Function that gets called when redis is updated (redis -> socketio -> this app)
  // Fetches rower keyvalue data from redis using openapi before adding it to data stream
  socket.on('updatemessage', (data) async {
    print('update message received');
    data = json.decode(data);
    String machineId = data["machine_id"];
    print(machineId);

    // Fetch rower keyvalue data from redis using openapi
    String method = 'machines/$machineId/keyvalues';
    print(method);

    final response =
        await openApiClient.get(endPoint: '$backendIP:22090', method: method);
    print('Response Body: ${response.body}');
    var res = json.decode(response.body);

    // Convert data received into a rower object
    Rower rower = Rower(
        // machineLocation: res['location'].toString(),
        machineLocation: 'SmartGymInABox',
        // machineName: res['name'].toString(),
        machineName: 'Rower',
        userId: res['user'].toString(),
        machineId: machineId,
        exerciseGroup: res['exercise_group'].toString(),
        distance: res['distance'].toDouble(),
        cadence: res['cadence'].toDouble(),
        calories: res['calories'].toDouble(),
        pace: res['pace'].toDouble(),
        power: res['power'].toDouble(),
        strokes: res['strokes'].toDouble(),
        workoutTime: res['workoutTime'].toDouble(),
        timestamp: res['timestamp'].toDouble());

    // Adds rower object to data stream
    streamSocket.addResponse(rower);
  });

  // Function that gets called when socketio disconnects
  // socket.onDisconnect((_) => print('disconnect'));
  socket.on('disconnect', (_) {
    print('Disconnected');
  });
}

// Widget used to display the rowing exercise
class RowerWidget1 extends StatefulWidget {
  // const RowerWidget({super.key});
  RowerWidget1({Key? key}) : super(key: key);

  @override
  State<RowerWidget1> createState() => _RowerWidget1State();
}

class _RowerWidget1State extends State<RowerWidget1> {
  String bigData = 'distance';
  String mediumDataLeft = 'strokes';
  String mediumDataRight = 'timestamp';
  String draggable1 = 'cadence';
  String draggable2 = 'calories';
  String draggable3 = 'pace';
  String draggable4 = 'power';
  String draggable5 = 'workoutTime';
  String temp = 'temp';
  String holder = 'holder';

  Map<String, String> unitMap = {
    'distance': 'meters',
    'cadence': 'spm',
    'calories': 'cals',
    'strokes': 'strokes',
    'pace': 'mins/500m',
    'power': 'watt',
    'workoutTime': 'secs',
    'timestamp': 'secs',
  };

  // Initialization function that connects and listen to socketio
  @override
  void initState() {
    connectAndListen();
    super.initState();
  }

  // Builds the layout of the widget
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: streamSocket.getResponse,
        initialData: dummyRower,
        builder: (BuildContext context, AsyncSnapshot<Rower> snapshot) {
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
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
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
                        child: MetricCard(
                          metric: draggable1,
                          value: snapshot.data!.get(this.draggable1).toString(),
                          units: unitMap[draggable1].toString(),
                        ),
                        feedback: Container(
                            height: 50.0, width: 50.0, color: Colors.orange),
                        onDragStarted: () => temp = draggable1,
                        onDragCompleted: () => draggable1 = holder,
                      ),
                      Expanded(
                        child: Container(
                            child: VerticalDivider(
                          color: Colors.black,
                        )),
                      ),
                      Draggable(
                        data: draggable2,
                        child: MetricCard(
                            metric: draggable2,
                            value:
                                snapshot.data!.get(this.draggable2).toString(),
                            units: unitMap[draggable2].toString()),
                        feedback: Container(
                            height: 50.0, width: 50.0, color: Colors.orange),
                        onDragStarted: () => temp = draggable2,
                        onDragCompleted: () => draggable2 = holder,
                      ),
                      Expanded(
                        child: Container(
                            child: VerticalDivider(
                          color: Colors.black,
                        )),
                      ),
                      Draggable(
                        data: draggable3,
                        child: MetricCard(
                            metric: draggable3,
                            value:
                                snapshot.data!.get(this.draggable3).toString(),
                            units: unitMap[draggable3].toString()),
                        feedback: Container(
                            height: 50.0, width: 50.0, color: Colors.orange),
                        onDragStarted: () => temp = draggable3,
                        onDragCompleted: () => draggable3 = holder,
                      ),
                      Expanded(
                        child: Container(
                            child: VerticalDivider(
                          color: Colors.black,
                        )),
                      ),
                      Draggable(
                        data: draggable4,
                        child: MetricCard(
                            metric: draggable4,
                            value:
                                snapshot.data!.get(this.draggable4).toString(),
                            units: unitMap[draggable4].toString()),
                        feedback: Container(
                            height: 50.0, width: 50.0, color: Colors.orange),
                        onDragStarted: () => temp = draggable4,
                        onDragCompleted: () => draggable4 = holder,
                      ),
                      Expanded(
                        child: Container(
                            child: VerticalDivider(
                          color: Colors.black,
                        )),
                      ),
                      Draggable(
                        data: draggable5,
                        child: MetricCard(
                            metric: draggable5,
                            value:
                                snapshot.data!.get(this.draggable5).toString(),
                            units: unitMap[draggable5].toString()),
                        feedback: Container(
                            height: 50.0, width: 50.0, color: Colors.orange),
                        onDragStarted: () => temp = draggable5,
                        onDragCompleted: () => draggable5 = holder,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () => print('button pressed'),
                            child: Text('Stop')),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    child: Divider(
                  color: Colors.black,
                )),
              ),
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
                          return MetricCard(
                              metric: mediumDataLeft,
                              value: snapshot.data!
                                  .get(this.mediumDataLeft)
                                  .toString(),
                              units: unitMap[mediumDataLeft].toString());
                        },
                        onAccept: (data) {
                          setState(() {
                            holder = mediumDataLeft;
                            mediumDataLeft = temp;
                          });
                        },
                      ),
                      Expanded(
                        child: Container(
                            child: VerticalDivider(
                          color: Colors.black,
                        )),
                      ),
                      DragTarget(
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return MetricCard(
                              metric: bigData,
                              value:
                                  snapshot.data!.get(this.bigData).toString(),
                              units: unitMap[bigData].toString());
                        },
                        onAccept: (data) {
                          setState(() {
                            holder = bigData;
                            bigData = temp;
                          });
                        },
                      ),
                      Expanded(
                        child: Container(
                            child: VerticalDivider(
                          color: Colors.black,
                        )),
                      ),
                      DragTarget(
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return MetricCard(
                              metric: mediumDataRight,
                              value: snapshot.data!
                                  .get(this.mediumDataRight)
                                  .toString(),
                              units: unitMap[mediumDataRight].toString());
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
        },
      ),
    );
  }
}
