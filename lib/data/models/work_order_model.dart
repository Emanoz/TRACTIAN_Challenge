import 'package:tractian_app/data/models/base_model.dart';

import '../../utils/enums/assets_status.dart';

class WorkOrder extends BaseModel {
  int orderId = 0;
  final String title;
  final String description;
  final String priority;
  final List<dynamic> assignedUserIds;
  final int assetId;
  final List<dynamic> checklist;
  late String status;

  WorkOrder(
      this.orderId, this.title, this.description, this.priority, this.assetId, this.assignedUserIds, this.checklist, this.status)
      : super.fromJson({'id': orderId});

  WorkOrder.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        priority = json['priority'],
        assignedUserIds = json['assignedUserIds'],
        assetId = json['assetId'],
        checklist = json['checklist'],
        status = json['status'],
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
        'status': status,
      };

  AssetsStatus checkPriority() {
    switch(priority) {
      case 'open':
        return AssetsStatus.open;
      case 'inProgress':
        return AssetsStatus.inProgress;
      case 'completed':
        return AssetsStatus.completed;
      case 'done':
        return AssetsStatus.done;
      case 'onHold':
        return AssetsStatus.onHold;
      case 'high':
        return AssetsStatus.high;
      case 'medium':
        return AssetsStatus.medium;
      case 'low':
        return AssetsStatus.low;
      default:
        return AssetsStatus.done;
    }
  }

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
      default:
        return AssetsStatus.done;
    }
  }

  int statusId() {
    switch(status) {
      case 'open':
        return 0;
      case 'in progress':
        return 1;
      case 'completed':
        return 2;
      default:
        return -1;
    }
  }
}
