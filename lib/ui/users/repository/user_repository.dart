import 'package:dio/dio.dart';
import 'package:tractian_app/data/models/user_model.dart';

import '../../../data/api/services/user_service.dart';
import '../../../utils/adapter_controller.dart';
import '../../../utils/enums/states.dart';
import '../../../utils/repository_interface.dart';

class UserRepository extends Repository<User> {
  UserRepository({required Dio api, required AdapterController<User> controller}) : super(api, controller);

  @override
  void delete(User model) {
    // TODO: implement delete
  }

  @override
  Future getAll() async {
    controller.currentState = States.loading;
    var response = await api.get(UserService.users.url());
    Iterable l = response.data;
    List<User> assets = List.from(l.map((model) => User.fromJson(model)));
    controller.insertAll(assets);
    controller.currentState = States.done;
  }

  @override
  Future getById(int id) async {
    controller.currentState = States.loading;
    var response = await api.get('${UserService.usersById.url()}/$id');
    controller.insert(User.fromJson(response.data));
    controller.currentState = States.done;
  }

  @override
  void insert(User model) {
    // TODO: implement insert
  }

  @override
  Future update(User model) {
    return Future.delayed(const Duration(seconds: 1));
  }
}