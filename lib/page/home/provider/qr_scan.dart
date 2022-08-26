import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonEncode;
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter/rendering.dart';

class QRScan extends StatefulWidget {
  const QRScan({super.key});

  @override
  State<QRScan> createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
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
    // print(Platform.operatingSystem);
    // controller!.resumeCamera();
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
              Container(
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                      borderColor: Colors.transparent,
                      overlayColor: Colors.transparent),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                height: 100,
                color: Colors.white,
                child: (result != null)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Barcode Type: ${describeEnum(result!.format)}\nData: ${result!.code}',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 12,
                            ),
                          ),
                          // InkWell(
                          //   child: const Text(
                          //     'Go',
                          //     style: TextStyle(
                          //       color: Colors.blue,
                          //       fontSize: 12,
                          //     ),
                          //   ),
                          //   onTap: () {
                          //     onScan(result?.code);
                          //   },
                          // ),
                        ],
                      )
                    : Center(child: Text('Scan a code')),
              )
            ],
          )),
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

  void onScan(String? uri) async {
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
