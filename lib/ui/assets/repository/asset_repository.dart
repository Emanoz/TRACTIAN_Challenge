import 'package:dio/dio.dart';
import 'package:tractian_app/data/models/asset_model.dart';
import 'package:tractian_app/data/models/work_order_model.dart';
import 'package:tractian_app/utils/repository_interface.dart';

import '../../../data/api/services/asset_service.dart';
import '../../../data/api/services/work_order_service.dart';
import '../../../utils/adapter_controller.dart';
import '../../../utils/enums/states.dart';

class AssetRepository extends Repository<Asset> {
  AssetRepository({required Dio api, required AdapterController<Asset> controller}) : super(api, controller);

  @override
  void delete(Asset model) {
    // TODO: implement delete
  }

  @override
  Future getAll() async {
    controller.currentState = States.loading;
    var response = await api.get(AssetService.assets.url());
    Iterable l = response.data;
    List<Asset> assets = List.from(l.map((model) => Asset.fromJson(model)));
    controller.insertAll(assets);
    controller.currentState = States.done;
  }

  @override
  Future getById(int id) async {
    controller.currentState = States.loading;
    var response = await api.get('${AssetService.assetById.url()}/$id');
    controller.insert(Asset.fromJson(response.data));
    controller.currentState = States.done;
  }

  @override
  void insert(Asset model) {
    // TODO: implement insert
  }

  @override
  Future update(Asset model) {
    return Future.delayed(const Duration(seconds: 1));
  }

  Future<String> countOpenOrders(int assetId) async {
    int count = 0;

    controller.currentState = States.loading;
    var response = await api.get(WorkOrderService.orders.url());
    Iterable l = response.data;
    List<WorkOrder> orders = List.from(l.map((model) => WorkOrder.fromJson(model)));
    count = orders.where((element) => element.assetId == assetId).length;
    controller.currentState = States.done;
    return count.toString();
  }

}