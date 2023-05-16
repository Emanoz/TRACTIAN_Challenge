import 'package:tractian_app/data/api/api_manager.dart';

enum AssetServiceExtension {
  assets,
  //Add more work order related endpoints as available
}

extension AssetService on AssetServiceExtension {
  String url() {
    switch(this) {
      case AssetServiceExtension.assets:
        return '${ApiManager.baseApiUrl}/assets';
    }
  }
}