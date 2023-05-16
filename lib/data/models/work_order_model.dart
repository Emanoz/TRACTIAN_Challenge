import 'package:tractian_app/data/models/base_model.dart';
import 'package:tractian_app/data/models/user_model.dart';

import 'asset_model.dart';
import 'checklist_model.dart';

class WorkOrder extends BaseModel{
  final String title;
  final String description;
  final String priority;
  final User assignedUser;
  final Asset asset;
  final List<Checklist> checklist;

  WorkOrder(this.title, this.description, this.priority, this.asset, this.assignedUser, this.checklist) : super.fromJson({});

  WorkOrder.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        priority = json['priority'],
        assignedUser = json['assignedUser'],
        asset = json['asset'],
        checklist = json['checklist'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'priority': priority,
    'assignedUser': assignedUser,
    'asset': asset,
    'checklist': checklist,
  };
}