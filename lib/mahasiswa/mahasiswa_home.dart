import 'package:flutter/material.dart';
import 'qr_scan_page.dart';
import 'gps_page.dart';
import 'accelerometer_page.dart';

class MahasiswaHome extends StatelessWidget {
  const MahasiswaHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mahasiswa App")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            menu(context, "Presensi QR", const QrScanPage()),
            menu(context, "GPS Tracking", const GpsPage()),
            menu(context, "Accelerometer", const AccelerometerPage()),
          ],
        ),
      ),
    );
  }

  Widget menu(BuildContext context, String text, Widget page) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
        child: Text(text),
      ),
    );
  }
}