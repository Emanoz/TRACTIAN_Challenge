import '../../../main.dart';

enum AssetService {
  assets,
  //Add more work order related endpoints as available
}

extension AssetServiceExtension on AssetService {
  String url() {
    switch(this) {
      case AssetService.assets:
        return '$baseUrl/assets';
    }
  }
}