import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScan2 extends StatefulWidget {
  const QRScan2({super.key});

  @override
  State<QRScan2> createState() => _QRScan2State();
}

class _QRScan2State extends State<QRScan2> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  // @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      print('Android');
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      print('IOS');
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    // debugPaintSizeEnabled = true; // After Build Widget
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                      borderColor: Colors.transparent,
                      overlayColor: Colors.transparent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        onScan(scanData.code);
      });
    });
  }

  Future<void> onScan(String? uri) async {
    final _url = Uri.parse(uri!);
    if (!await launchUrl(_url, webOnlyWindowName: '_self')) {
      throw 'Could not launch $_url';
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
