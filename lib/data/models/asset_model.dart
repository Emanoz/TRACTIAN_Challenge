import 'package:tractian_app/data/models/base_model.dart';
import 'package:tractian_app/data/models/specifications_model.dart';
import 'package:tractian_app/data/models/user_model.dart';
import 'health_history_model.dart';
import 'metrics_model.dart';

class Asset extends BaseModel {
  final List<dynamic> assignedUserIds;
  final int companyId;
  final List<dynamic> healthHistory;
  final int? healthScore;
  final String image;
  final Metrics metrics;
  final String model;
  final String name;
  final List<dynamic> sensors;
  final Specifications specifications;
  final String status;
  final int unitId;

  Asset(this.assignedUserIds, this.companyId, this.healthHistory, this.healthScore, this.image, this.metrics,
      this.model, this.name, this.sensors, this.specifications, this.status, this.unitId) : super.fromJson({});

  Asset.fromJson(Map<String, dynamic> json)
      : assignedUserIds = json['assignedUserIds'],
        companyId = json['companyId'],
        healthHistory = json['healthHistory'],
        healthScore = json['healthScore'],
        image = json['image'],
        metrics = Metrics.fromJson(json['metrics']),
        model = json['model'],
        name = json['name'],
        sensors = json['sensors'],
        specifications = Specifications.fromJson(json['specifications']),
        status = json['status'],
        unitId = json['unitId'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'assignedUsersIds': assignedUserIds,
    'companyId': companyId,
    'healthHistory': healthHistory,
    'healthScore': healthScore,
    'image': image,
    'metrics': metrics,
    'model': model,
    'name': name,
    'sensors': sensors,
    'specifications': specifications,
    'status': status,
    'unitId': unitId,
  };
}
