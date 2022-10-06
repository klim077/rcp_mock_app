import 'dart:convert';
import 'dart:html';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:socket_io_client/socket_io_client.dart';
import 'config.dart';

// class RowerWidget extends StatefulWidget {
//   const RowerWidget({super.key});

//   @override
//   State<RowerWidget> createState() => _RowerWidgetState();
// }

// class _RowerWidgetState extends State<RowerWidget> {

//   late IO.Socket socket;
//   @override
//   void initState() {
//     initSocket();
//     super.initState();
//   }
//   initSocket() {
//     // socket = IO.io("http://192.168.1.119/socket.io/",
//     socket = IO.io("$backendURL/socket.io/",
//     //  <String, dynamic>{
//     //   'autoConnect': true,
//     //   'setTransports': ['websocket'],
//     // }
//     );
//     socket.connect();
//     socket.onConnect((_) {
//       print('Connection established');
//     });
//     socket.onDisconnect((_) => print('Connection Disconnection'));
//     socket.onConnectError((err) => print(err));
//     socket.onError((err) => print(err));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("a"),
//     );
//   }
// }




// STEP1:  Stream setup
class StreamSocket{
  final _socketResponse= StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose(){
    _socketResponse.close();
  }
}

StreamSocket streamSocket =StreamSocket();

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
void connectAndListen(){
  // print('$backendURL/socket.io/');
  // IO.Socket socket = IO.io("$backendURL/socket.io/",
  //     IO.OptionBuilder()
  //      .setTransports(['websocket'])
  //      .build()
  //      );

  IO.Socket socket = IO.io('$backendURL', {
    'path': '/socket.io/',
    'autoConnect': false,
    'transports': ['websocket']
  });
  socket.connect();
    // socket.onConnect((_) {
    //  print('connect');
    //  socket.emit('mobileConnected', '{ "channel" : 123456 }');
    // });
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
      print(data["machine_id"]);
      streamSocket.addResponse;
    });
    socket.onDisconnect((_) => print('disconnect'));

}

//Step3: Build widgets with streambuilder

class BuildWithSocketStream extends StatelessWidget {
  const BuildWithSocketStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: streamSocket.getResponse ,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot){
          return Container(
            // child: Text(snapshot.data.toString()),
            child: ElevatedButton(onPressed: connectAndListen, child: Text('connect socketio'),)
          );
        },
      ),
    );
  }
}

class RowerStreamTest extends StatefulWidget {
  // const RowerStreamTest({super.key});
  const RowerStreamTest({Key? key}) : super(key: key);

  @override
  State<RowerStreamTest> createState() => _RowerStreamTestState();
}

class _RowerStreamTestState extends State<RowerStreamTest> {
  @override
  void initState(){
    connectAndListen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: StreamBuilder(
        stream: streamSocket.getResponse ,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot){
          return Container(
            child: Text(snapshot.data.toString()),
          );
        },
      ),);
  }
}