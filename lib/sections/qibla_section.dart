import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensors_plus/sensors_plus.dart';

class QiblahCompassWidget extends StatefulWidget {
  const QiblahCompassWidget({super.key});

  @override
  State<QiblahCompassWidget> createState() => _QiblahCompassWidgetState();
}

class _QiblahCompassWidgetState extends State<QiblahCompassWidget> {
  double? _qiblahDirection;
  double? _heading;

  StreamSubscription<AccelerometerEvent>? _accelSub;
  StreamSubscription<MagnetometerEvent>? _magnetSub;

  List<double>? _accelData;
  List<double>? _magnetData;

  @override
  void initState() {
    super.initState();
    _fetchLocationAndQiblah();
    _listenToSensors();
  }

  void _listenToSensors() {
    _accelSub = accelerometerEventStream().listen((event) {
      _accelData = [event.x, event.y, event.z];
      _updateHeading();
    });

    _magnetSub = magnetometerEventStream().listen((event) {
      _magnetData = [event.x, event.y, event.z];
      _updateHeading();
    });
  }

  void _updateHeading() {
    if (_accelData == null || _magnetData == null) return;

    final ax = _accelData![0], ay = _accelData![1], az = _accelData![2];
    final mx = _magnetData![0], my = _magnetData![1], mz = _magnetData![2];

    final normA = sqrt(ax * ax + ay * ay + az * az);
    final normM = sqrt(mx * mx + my * my + mz * mz);

    final axn = ax / normA;
    final ayn = ay / normA;
    final azn = az / normA;

    final mxn = mx / normM;
    final myn = my / normM;
    final mzn = mz / normM;

    // Cross products and heading calculation
    final hx = myn * azn - mzn * ayn;
    final hy = mzn * axn - mxn * azn;
    final hz = mxn * ayn - myn * axn;

    final normH = sqrt(hx * hx + hy * hy + hz * hz);
    final hxNorm = hx / normH;
    final hyNorm = hy / normH;

    double heading = atan2(hyNorm, hxNorm) * (180 / pi);
    if (heading < 0) heading += 360;

    setState(() {
      _heading = heading;
    });
  }

  Future<void> _fetchLocationAndQiblah() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) return;

    final pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
    setState(() {
      _qiblahDirection = _calculateQiblahAngle(pos.latitude, pos.longitude);
    });
  }

  double _calculateQiblahAngle(double lat, double lon) {
    const kaabaLat = 21.4225;
    const kaabaLng = 39.8262;

    final phiK = kaabaLat * pi / 180;
    final phiL = lat * pi / 180;
    final deltaLng = (kaabaLng - lon) * pi / 180;

    final qiblahRadians = atan2(
      sin(deltaLng),
      cos(phiL) * tan(phiK) - sin(phiL) * cos(deltaLng),
    );

    final qiblahDegrees = qiblahRadians * 180 / pi;
    return (qiblahDegrees + 360) % 360;
  }

  double _calculateNeedleAngle() {
    if (_heading == null || _qiblahDirection == null) return 0;
    final angle = (_qiblahDirection! - _heading!) % 360;
    return angle * (pi / 180);
  }

  @override
  void dispose() {
    _accelSub?.cancel();
    _magnetSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_heading == null || _qiblahDirection == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Compass Circle
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400, width: 4),
            ),
            child: const Center(
              child: Text(
                'N',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Qiblah Arrow
          Transform.rotate(
            angle: _calculateNeedleAngle(),
            child: const Icon(
              Icons.navigation, // Simple arrow icon
              size: 80,
              color: Colors.green,
            ),
          ),

          const Positioned(
            bottom: 20,
            child: Text("Compass",style: TextStyle(fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }
}
