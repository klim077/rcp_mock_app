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
import 'openapi_client.dart';
import 'rower_model.dart';

// STEP1:  Stream setup
class StreamSocket{
  final _socketResponse= StreamController<Rower>();

  void Function(Rower) get addResponse => _socketResponse.sink.add;

  Stream<Rower> get getResponse => _socketResponse.stream;

  void dispose(){
    _socketResponse.close();
  }
}

StreamSocket streamSocket =StreamSocket();

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
void connectAndListen(){
  IO.Socket socket = IO.io('$backendURL', {
    'path': '/socket.io/',
    'autoConnect': false,
    'transports': ['websocket']
  });

  socket.connect();
  final OpenApiClient openApiClient = OpenApiClient();
  

  socket.on('connect', (_) {
    print('Connected');
    var channel = '{ "channel" : "123456" }';
    socket.emit('mobileConnected', channel);
    print('emitted: $channel');

  });

    //When an event recieved from server, data is added to the stream
    // socket.on('updatemessage', (data) => streamSocket.addResponse);
    socket.on('updatemessage', (data) async {
      print('update message received');
      data = json.decode(data);
      String machineId = data["machine_id"];
      print(machineId);
      String method = 'machines/$machineId/keyvalues';
      print(method);

      final response = await openApiClient.get(
        endPoint: '$backendIP:22090', 
        method: method);
      print('Response Body: ${response.body}');
      var res = json.decode(response.body);

      Rower rower = Rower(
        machineLocation: res['location'].toString(),
        machineName: res['name'].toString(),
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
        timestamp: res['timestamp'].toDouble()
      );
      streamSocket.addResponse(rower);
    });
    socket.onDisconnect((_) => print('disconnect'));

}


class RowerWidget extends StatefulWidget {
  // const RowerWidget({super.key});
  const RowerWidget({Key? key}) : super(key: key);

  @override
  State<RowerWidget> createState() => _RowerWidgetState();
}

class _RowerWidgetState extends State<RowerWidget> {

  Rower dummyRower = Rower(
          machineLocation: '',
          machineName: '',
          userId: '',
          machineId: '',
          exerciseGroup: '',
          distance: double.nan,
          cadence: double.nan,
          calories: double.nan,
          pace: double.nan,
          power: double.nan,
          strokes: double.nan,
          workoutTime: double.nan,
          timestamp: double.nan
        );



  @override
  void initState(){
    connectAndListen();
    super.initState();
    streamSocket.addResponse(dummyRower);
    print('added dummy');
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: StreamBuilder(
        stream: streamSocket.getResponse ,
        initialData: dummyRower,
        builder: (BuildContext context, AsyncSnapshot<Rower> snapshot){
          return Container(
            child: Text(snapshot.data!.strokes.toString()
                          ),
          );
        },
      ),);
  }
}


