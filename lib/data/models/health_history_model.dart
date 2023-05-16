import 'package:tractian_app/data/models/base_model.dart';

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
}