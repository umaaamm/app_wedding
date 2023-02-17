import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:app_wedding/Services/Services.dart';
import 'package:app_wedding/main.dart';
import 'package:app_wedding/model/countModel.dart';
import 'package:app_wedding/model/responseEdit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/services.dart';
import 'model/undanganModel.dart';
import 'package:vibration/vibration.dart';

class scan extends StatelessWidget {

  const scan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRViewExample(),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  Future<undanganModel>? _undangan;
  Future<countModel>? _count;

  final Services _services = Services();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: <Widget>[
            AppBar(
              backgroundColor: HexColor("#40BD63"),
              title: Text("Scan QR Code"),
            ),
            Expanded(flex: 4, child: _buildQrView(context)),
          ],
        ),
        Center(
          child: (result != null)
              ? FutureBuilder<responseEdit>(
                  future: _services.updateKeterangan(result!.code.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Vibration.vibrate(duration: 300);
                      if (snapshot.data?.message == 'ok') {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          //When finish, call actions inside
                          Future.delayed(Duration.zero, () {
                            Navigator.of(context).pop("reload");
                          });
                        });
                      }
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Card(
                        child: Container(
                          height: 80,
                          child:Padding(
                            padding: EdgeInsets.all(16),
                            child: SizedBox(
                            height: 50,
                            width: 50,
                            child:  CircularProgressIndicator(),
                          ),
                          ),
                        ),
                        color: Colors.white,
                        margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      );
                  })
              : null,
        )
      ],
    ));
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: HexColor("#40BD63"),
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller!.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
