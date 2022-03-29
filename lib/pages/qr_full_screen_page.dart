import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrFullScreen extends StatelessWidget {
  final String qr;
  const QrFullScreen({Key? key, required this.qr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {Navigator.of(context).pop()},
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.5),
        body: Center(
            child: QrImage(
          backgroundColor: Colors.white,
          data: qr,
          version: QrVersions.auto,
          padding: const EdgeInsets.all(20),
        )),
      ),
    );
  }
}
