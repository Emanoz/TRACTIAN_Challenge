import 'package:dio/dio.dart';
import 'package:tractian_app/utils/adapter_controller.dart';

import '../data/models/base_model.dart';

abstract class Repository<T extends BaseModel> {
  Dio api;
  AdapterController<T> controller;

  Repository(this.api, this.controller);

  void insert(T model);
  void delete(T model);
  Future update(T model);
  Future getAll();
  Future getById(int id);
}