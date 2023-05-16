import 'package:tractian_app/data/api/api_manager.dart';

enum WorkOrderExtension {
  orders,
  //Add more work order related endpoints as available
}

extension WorkOrderService on WorkOrderExtension {
  String url() {
    switch(this) {
      case WorkOrderExtension.orders:
        return '${ApiManager.baseApiUrl}/workorders';
    }
  }
}