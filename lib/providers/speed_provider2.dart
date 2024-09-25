import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';
import 'speed_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final speedProvider = StreamProvider<List<Speed>>((ref) async* {
  Position curr, last1, last2, last3, last4;
  curr = await determinePosition();
  last1 = curr;
  last2 = curr;
  last3 = curr;
  last4 = curr;
  int time, time1, time2, time3, time4;
  time = DateTime.now().millisecondsSinceEpoch;
  time1 = time;
  time2 = time;
  time3 = time;
  time4 = time;

  const LocationSettings locationSettings =
      LocationSettings(accuracy: LocationAccuracy.high);
  await for (final p
      in Geolocator.getPositionStream(locationSettings: locationSettings)) {
    last4 = last3;
    last3 = last2;
    last2 = last1;
    last1 = curr;
    time4 = time3;
    time3 = time2;
    time2 = time1;
    time1 = time;
    curr = p;
    time = DateTime.now().millisecondsSinceEpoch;

    yield [
      Speed(
          dist: Geolocator.distanceBetween(
              last1.latitude, last1.longitude, curr.latitude, curr.longitude),
          time: time - time1),
      Speed(
          dist: Geolocator.distanceBetween(last4.latitude, last4.longitude,
                  last3.latitude, last3.longitude) +
              Geolocator.distanceBetween(last3.latitude, last3.longitude,
                  last2.latitude, last2.longitude) +
              Geolocator.distanceBetween(last2.latitude, last2.longitude,
                  last1.latitude, last1.longitude) +
              Geolocator.distanceBetween(last1.latitude, last1.longitude,
                  curr.latitude, curr.longitude),
          time: time - time4),
      Speed(
          dist: Geolocator.distanceBetween(
              last2.latitude, last2.longitude, curr.latitude, curr.longitude),
          time: time - time2),
      Speed(
          dist: Geolocator.distanceBetween(last4.latitude, last4.longitude,
                  last2.latitude, last2.longitude) +
              Geolocator.distanceBetween(last2.latitude, last2.longitude,
                  curr.latitude, curr.longitude),
          time: time - time4),
    ];
  }
});
