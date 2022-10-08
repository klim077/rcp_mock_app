import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'RowerWidget.dart';

class RowerPage extends StatefulWidget {
  const RowerPage({super.key});

  @override
  State<RowerPage> createState() => _RowerPageState();
}

class _RowerPageState extends State<RowerPage> {
  @override
  Widget build(BuildContext context) {
    print('Returning RowerStreamTest Widget');
    return Container(
      child: RowerWidget(),
      // child: RowerStreamTest(),
      // child: BuildWithSocketStream(),
    );
  }
}