import 'package:tractian_app/data/models/base_model.dart';

import '../../utils/enums/assets_status.dart';

class HealthHistory extends BaseModel {
  final String status;
  final String timestamp;

  HealthHistory(this.status, this.timestamp) : super.fromJson({});

  HealthHistory.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        timestamp = json['timestamp'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
    'status': status,
    'timestamp': timestamp,
  };

  AssetsStatus checkStatus() {
    switch(status) {
      case 'inOperation':
        return AssetsStatus.inOperation;
      case 'inDowntime':
        return AssetsStatus.inDowntime;
      case 'inAlert':
        return AssetsStatus.inAlert;
      case 'unplannedStop':
        return AssetsStatus.plannedStop;
      default:
        return AssetsStatus.done;
    }
  }
}