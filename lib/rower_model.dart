import 'dart:core';

import 'package:meta/meta.dart';

class Rower {
  final String machineId;
  final String userId;
  final String machineLocation;
  final String machineName;
  String exerciseGroup;
  double? distance;
  double? cadence;
  double? calories;
  double? pace;
  double? power;
  double? strokes;
  double? workoutTime;
  double? timestamp;
  bool? rec;

  Rower(
    {required this.machineId,
    required this.userId,
    required this.machineLocation,
    required this.machineName,
    required this.exerciseGroup,
    this.distance,
    this.cadence,
    this.calories,
    this.pace,
    this.power,
    this.strokes,
    this.workoutTime,
    this.timestamp,
    this.rec})
    :assert(machineId != null);

  String toString() {
    Map<String, dynamic> out = {
      'machineId': machineId,
      'userId': userId,
      'machineLocation': machineLocation,
      'machineName': machineName,
      'exerciseGroup': exerciseGroup,
      'distance': distance,
      'cadence': cadence,
      'calories': calories,
      'pace': pace,
      'power': power,
      'strokes': strokes,
      'workoutTime': workoutTime,
      'timestamp': timestamp,
      'rec': rec
    };
    return out.toString();
  }
}

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