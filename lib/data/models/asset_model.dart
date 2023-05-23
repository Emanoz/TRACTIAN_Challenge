import 'package:tractian_app/data/models/base_model.dart';

import '../../utils/enums/assets_status.dart';

class Asset extends BaseModel {
  final List<dynamic> assignedUserIds;
  final int? companyId;
  final List<dynamic>? healthHistory;
  final double healthScore;
  final String? image;
  final Map<String, dynamic>? metrics;
  final String? model;
  final String? name;
  final List<dynamic>? sensors;
  final Map<String, dynamic>? specifications;
  final String status;
  final int? unitId;

  Asset(this.assignedUserIds, this.companyId, this.healthHistory, this.healthScore, this.image, this.metrics,
      this.model, this.name, this.sensors, this.specifications, this.status, this.unitId) : super.fromJson({});

  Asset.fromJson(Map<String, dynamic> json)
      : assignedUserIds = json['assignedUserIds'],
        companyId = json['companyId'],
        healthHistory = json['healthHistory'],
        healthScore = double.parse(json['healthscore'].toString()),
        image = json['image'],
        metrics = json['metrics'],
        model = json['model'],
        name = json['name'],
        sensors = json['sensors'],
        specifications = json['specifications'],
        status = json['status'],
        unitId = json['unitId'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'assignedUsersIds': assignedUserIds,
    'companyId': companyId,
    'healthHistory': healthHistory,
    'healthscore': healthScore,
    'image': image,
    'metrics': metrics,
    'model': model,
    'name': name,
    'sensors': sensors,
    'specifications': specifications,
    'status': status,
    'unitId': unitId,
  };

  AssetsStatus checkStatus() {
    switch(status) {
      case 'open':
        return AssetsStatus.open;
      case 'in progress':
        return AssetsStatus.inProgress;
      case 'completed':
        return AssetsStatus.completed;
      case 'done':
        return AssetsStatus.done;
      case 'on hold':
        return AssetsStatus.onHold;
      case 'inAlert':
        return AssetsStatus.inAlert;
      case 'inOperation':
        return AssetsStatus.inOperation;
      case 'inDowntime':
        return AssetsStatus.inDowntime;
      default:
        return AssetsStatus.done;
    }
  }
}
