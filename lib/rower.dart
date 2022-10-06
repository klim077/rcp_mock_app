import 'package:meta/meta.dart';

class Rower {
  final String machineId;
  final String userId;
  final String machineLocation;
  final String machineName;
  String? exerciseGroup;
  double? strokes;
  double? cadence;
  double? distance; // meters
  double? calories; // kilo joules
  double? pace;
  double? power; // watts
  double? timestamp;
  double? workoutTime;
  bool? rec;

  Rower(
      {required this.machineId,
      required this.userId,
      required this.machineLocation,
      required this.machineName,
      required this.exerciseGroup,
      this.strokes,
      this.cadence,
      this.distance,
      this.calories,
      this.power,
      this.pace,
      this.timestamp,
      this.workoutTime,
      this.rec})
      : assert(machineId != null);

  String toString() {
    Map<String, dynamic> out = {
      'machineId': machineId,
      'machineName': machineName,
      'machineLocation': machineLocation,
      'userId': userId,
      'strokes': strokes,
      'cadence': cadence,
      'distance': distance,
      'calories': calories,
      'exerciseGroup': exerciseGroup,
      'power': power,
      'pace': pace,
      'timestamp': timestamp,
      'workoutTime': workoutTime,
      'rec': rec
    };
    return out.toString();
  }
}
