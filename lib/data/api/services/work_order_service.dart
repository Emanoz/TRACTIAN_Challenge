import '../../../main.dart';

enum WorkOrderService {
  orders,
  orderById,
  //Add more work order related endpoints as available
}

extension WorkOrderServiceExtension on WorkOrderService {
  String url() {
    switch(this) {
      case WorkOrderService.orders:
        return '$baseUrl/workorders';
      case WorkOrderService.orderById:
        return '$baseUrl/workorders/';
    }
  }
}