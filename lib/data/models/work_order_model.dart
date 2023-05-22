import 'package:tractian_app/data/models/base_model.dart';
import 'package:tractian_app/data/models/user_model.dart';

import 'asset_model.dart';
import 'checklist_model.dart';

class WorkOrder extends BaseModel{
  final String title;
  final String description;
  final String priority;
  final List<dynamic> assignedUserIds;
  final int assetId;
  final List<dynamic> checklist;

  WorkOrder(this.title, this.description, this.priority, this.assetId, this.assignedUserIds, this.checklist) : super.fromJson({});

  WorkOrder.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        priority = json['priority'],
        assignedUserIds = json['assignedUserIds'],
        assetId = json['assetId'],
        checklist = json['checklist'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'priority': priority,
    'assignedUserIds': assignedUserIds,
    'assetId': assetId,
    'checklist': checklist,
  };
}