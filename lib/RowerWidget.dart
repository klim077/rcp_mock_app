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

// This helps with the streaming of data
class StreamSocket{
  final _socketResponse= StreamController<Rower>();

  void Function(Rower) get addResponse => _socketResponse.sink.add;

  Stream<Rower> get getResponse => _socketResponse.stream;

  void dispose(){
    _socketResponse.close();
  }
}

StreamSocket streamSocket =StreamSocket();

// Function that connects and listens to socketio
void connectAndListen(){

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

      final response = await openApiClient.get(
        endPoint: '$backendIP:22090', 
        method: method);
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
        timestamp: res['timestamp'].toDouble()
      );

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
class RowerWidget extends StatefulWidget {
  // const RowerWidget({super.key});
  RowerWidget({Key? key}) : super(key: key);
  String draggable1 = 'distance';

  @override
  State<RowerWidget> createState() => _RowerWidgetState();
}

class _RowerWidgetState extends State<RowerWidget> {

  // Initialization function that connects and listen to socketio
  @override
  void initState(){
    connectAndListen();
    super.initState();
  }

  // Builds the layout of the widget
  @override
  Widget build(BuildContext context) {
    return Container(child: StreamBuilder(
        stream: streamSocket.getResponse ,
        initialData: dummyRower,
        builder: (BuildContext context, AsyncSnapshot<Rower> snapshot){
          // return Container(
          //   child: Text(snapshot.data!.strokes.toString()
          //                 ),
          // );
          return Scaffold(
            appBar: AppBar(title: Text('RCP Rower Demo')),
            body: Center(
              child: 
              
              Row(children: [
                Expanded(flex:1,child:
                Column(children: [
                  Image.asset('rowingmachine.png'),
                  // Flexible(flex:1, child: Text('Location: ${snapshot.data!.machineLocation}'),),
                  
                  Flexible(flex:1, child: Text('Location: ${snapshot.data!.get(this.widget.draggable1)}'),),
                  Flexible(flex:1, child: Text('Machine Name: ${snapshot.data!.machineName}'),),
                  Flexible(flex:1, child: Text('Machine ID: ${snapshot.data!.machineId}'),),
                  Flexible(flex:1, child: Text('User ID: ${snapshot.data!.userId}'),)
                ],),),
                Expanded(flex:3,child:
                Center(child:
                Column(children: [
                  Flexible(flex:1, child: Text('Distance: ${snapshot.data!.distance.toString()}'),),
                  Flexible(flex:1, child: Text('Cadence: ${snapshot.data!.cadence.toString()}'),),
                  Flexible(flex:1, child: Text('Calories: ${snapshot.data!.calories.toString()}'),),
                  Flexible(flex:1, child: Text('Strokes: ${snapshot.data!.strokes.toString()}'),),
                ],),),),
                Expanded(flex:3,child:
                Column(children: [
                  Flexible(flex:1, child: Text('Pace: ${snapshot.data!.pace.toString()}'),),
                  Flexible(flex:1, child: Text('Power: ${snapshot.data!.power.toString()}'),),
                  Flexible(flex:1, child: Text('Workout Duration: ${snapshot.data!.workoutTime.toString()}'),),
                  Flexible(flex:1, child: Text('Total Duration: ${snapshot.data!.timestamp.toString()}'),),
                ],),),
              ],),)
          );
        },
      ),);
  }
}


