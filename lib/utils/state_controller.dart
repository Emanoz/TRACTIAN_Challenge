import 'package:mobx/mobx.dart';

part 'state_controller.g.dart';

class StateController<T> = StateControllerBase<T> with _$StateController;

abstract class StateControllerBase<T> with Store {
  StateControllerBase({required this.currentValue});

  @observable
  T currentValue;

  @action
  void setValueState(T state) {
    currentValue = state;
  }
}