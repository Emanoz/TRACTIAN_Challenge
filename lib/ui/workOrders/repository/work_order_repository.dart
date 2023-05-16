import 'package:dio/dio.dart';
import 'package:tractian_app/utils/repository_interface.dart';
import '../../../data/models/work_order_model.dart';
import '../../../utils/adapter_controller.dart';

class WorkOrderRepository extends Repository<WorkOrder> {
  WorkOrderRepository(Dio api, AdapterController<WorkOrder> controller) : super(api, controller);

  @override
  void delete(WorkOrder model) {

  }

  @override
  void getAll(List<WorkOrder> models) {
    // TODO: implement getAll
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