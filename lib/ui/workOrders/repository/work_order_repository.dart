import 'package:dio/dio.dart';
import 'package:tractian_app/data/api/services/work_order_service.dart';
import 'package:tractian_app/utils/enums/states.dart';
import 'package:tractian_app/utils/repository_interface.dart';

import '../../../data/models/work_order_model.dart';
import '../../../utils/adapter_controller.dart';

class WorkOrderRepository extends Repository<WorkOrder> {
  WorkOrderRepository({required Dio api, required AdapterController<WorkOrder> controller}) : super(api, controller);

  @override
  void delete(WorkOrder model) {

  }

  @override
  Future getAll() async {
    controller.currentState = States.loading;
    var response = await api.get(WorkOrderService.orders.url());
    Iterable l = response.data;
    List<WorkOrder> orders = List.from(l.map((model)=> WorkOrder.fromJson(model)));
    controller.insertAll(orders);
    controller.currentState = States.done;
  }

  @override
  Future getById(int id) {
    // TODO: implement getById
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  void insert(WorkOrder model) async {
    controller.currentState = States.loading;
    await api.post(WorkOrderService.orderById.url(), data: model.toJson());
    controller.insert(model);
    controller.currentState = States.done;
  }

  @override
  Future update(WorkOrder model) async {
    controller.currentState = States.loading;
    var response = await api.put('${WorkOrderService.orderById.url()}/${model.id}', data: model.toJson());
    controller.update(WorkOrder.fromJson(response.data));
    controller.currentState = States.done;
  }

  Future<int> generateId() async {
    controller.currentState = States.loading;
    var response = await api.get(WorkOrderService.orders.url());
    Iterable l = response.data;
    List<WorkOrder> orders = List.from(l.map((model)=> WorkOrder.fromJson(model)));
    controller.currentState = States.done;
    return orders.last.id! + 1;
  }
}