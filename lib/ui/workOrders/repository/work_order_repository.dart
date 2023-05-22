import 'dart:convert';

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
  void getAll() async {
    controller.currentState = States.loading;
    var response = await api.get(WorkOrderService.orders.url());
    Iterable l = response.data;
    List<WorkOrder> orders = List.from(l.map((model)=> WorkOrder.fromJson(model)));
    controller.insertAll(orders);
    controller.currentState = States.done;
  }

  @override
  void getById(int id) {
    // TODO: implement getById
  }

  @override
  void insert(WorkOrder model) {
    // TODO: implement insert
  }

  @override
  void update(WorkOrder model) {
    // TODO: implement update
  }

}