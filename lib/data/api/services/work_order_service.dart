import '../../../main.dart';

enum WorkOrderService {
  orders,
  //Add more work order related endpoints as available
}

extension WorkOrderServiceExtension on WorkOrderService {
  String url() {
    switch(this) {
      case WorkOrderService.orders:
        return '$baseUrl/workorders';
    }
  }
}