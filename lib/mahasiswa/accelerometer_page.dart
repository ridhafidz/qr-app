import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerPage extends StatefulWidget {
  const AccelerometerPage({super.key});

  @override
  State<AccelerometerPage> createState() => _AccelerometerPageState();
}

class _AccelerometerPageState extends State<AccelerometerPage> {
  double x = 0, y = 0, z = 0;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Accelerometer")),
      body: Center(
        child: Text(
          "X: ${x.toStringAsFixed(2)}\n"
          "Y: ${y.toStringAsFixed(2)}\n"
          "Z: ${z.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}