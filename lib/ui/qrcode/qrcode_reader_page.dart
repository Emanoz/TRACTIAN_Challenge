import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tractian_app/data/models/asset_model.dart';
import 'package:tractian_app/ui/assets/asset_detail_page.dart';
import 'package:tractian_app/ui/assets/repository/asset_repository.dart';
import 'package:tractian_app/utils/adapter_controller.dart';

class QrCodeReaderPage extends StatelessWidget {
  const QrCodeReaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.normal,
            detectionTimeoutMs: 3000,
            facing: CameraFacing.back,
          ),
          onDetect: (capture) async {
            final asset = Asset.fromJson(jsonDecode(capture.barcodes.first.rawValue!));
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AssetDetailPage(
                  asset: asset,
                  repository: AssetRepository(
                    api: Dio(),
                    controller: AdapterController<Asset>(),
                  ),
                ),
              ),
            );
            Future.delayed(const Duration(seconds: 1));
          },
        ),
        ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.srcOut),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.black, backgroundBlendMode: BlendMode.dstOut),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height - 500,
                  width: MediaQuery.of(context).size.width - 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
