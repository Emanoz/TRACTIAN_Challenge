import 'package:mobx/mobx.dart';
import 'package:tractian_app/data/models/base_model.dart';

import 'enums/states.dart';

part 'adapter_controller.g.dart';

class AdapterController<T extends BaseModel> = AdapterControllerBase<T> with _$AdapterController;

abstract class AdapterControllerBase<T extends BaseModel> with Store {
  @observable
  ObservableList<T> list = ObservableList();

  @observable
  States currentState = States.done;

  @action
  void insert(T item) {
    list.add(item);
  }

  @action
  void insertAll(List<T> items) {
    list.clear();
    list.addAll(items);
  }

  @action
  void delete(T item) {
    list.remove(item);
  }

  @action
  void update(T item) {
    final index = list.indexWhere((element) => element.id == item.id);
    list[index] = item;
  }
}