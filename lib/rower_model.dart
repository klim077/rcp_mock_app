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
  double? rowingTime;
  double? heartRate;
  double? interval;
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
    this.rowingTime,
    this.heartRate,
    this.interval,
    this.rec})
    :assert(machineId != null);

  String toRowerString() {
    Map<String, dynamic> out = {
      '"machineId"': machineId,
      '"userId"': userId,
      '"machineLocation"': machineLocation,
      '"machineName"': machineName,
      '"exerciseGroup"': exerciseGroup,
      '"distance"': "$distance",
      '"cadence"': "$cadence",
      '"calories"': "$calories",
      '"pace"': "$pace",
      '"power"': "$power",
      '"strokes"': "$strokes",
      '"workoutTime"': "$workoutTime",
      '"timestamp"': "$timestamp",
      '"rowingTime"': "$rowingTime",
      '"heartRate"': "$heartRate",
      '"interval"': "$interval",
      '"rec"': "$rec"
    };
    return out.toString();
  }

  Map<String, dynamic> toMap() {
    return{
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
      'rowingTime': rowingTime,
      'heartRate': heartRate,
      'interval': interval,
      'rec': rec
    };}

  dynamic get(String propertyName) {
    var _mapRep = toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

Rower dummyRower = Rower(
        machineLocation: '',
        machineName: '',
        userId: '',
        machineId: '',
        exerciseGroup: '',
        // distance: double.nan,
        // cadence: double.nan,
        // calories: double.nan,
        // pace: double.nan,
        // power: double.nan,
        // strokes: double.nan,
        // workoutTime: double.nan,
        // timestamp: double.nan
        distance: 0.00,
        cadence: 0.00,
        calories: 0.00,
        pace: 0.00,
        power: 0.00,
        strokes: 0.00,
        workoutTime: 0.00,
        timestamp: 0.00,
        rowingTime: 0.00,
        heartRate: 0.00,
        interval: 0.00
      );
      