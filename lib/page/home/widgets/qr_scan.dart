import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScan extends StatelessWidget {
  QRScan({super.key});

  final cameraController = MobileScannerController();

  Future<void> onScan(Barcode barcode, MobileScannerArguments? args) async {
    final _url = Uri.parse(barcode.rawValue!);
    if (!await launchUrl(_url, webOnlyWindowName: '_self')) {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state! as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32,
            onPressed: cameraController.toggleTorch,
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state! as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32,
            onPressed: cameraController.switchCamera,
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: onScan,
      ),
    );
  }
}
