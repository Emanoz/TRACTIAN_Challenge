import '../../../main.dart';

enum AssetService {
  assets,
  assetById
  //Add more work order related endpoints as available
}

extension AssetServiceExtension on AssetService {
  String url() {
    switch(this) {
      case AssetService.assets:
        return '$baseUrl/assets';
      case AssetService.assetById:
        return '$baseUrl/assets/';
    }
  }
}