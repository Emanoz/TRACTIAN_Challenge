// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adapter_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AdapterController<T extends BaseModel>
    on AdapterControllerBase<T>, Store {
  late final _$listAtom =
      Atom(name: 'AdapterControllerBase.list', context: context);

  @override
  ObservableList<T> get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(ObservableList<T> value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  late final _$AdapterControllerBaseActionController =
      ActionController(name: 'AdapterControllerBase', context: context);

  @override
  void insert(T item) {
    final _$actionInfo = _$AdapterControllerBaseActionController.startAction(
        name: 'AdapterControllerBase.insert');
    try {
      return super.insert(item);
    } finally {
      _$AdapterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void insertAll(List<T> items) {
    final _$actionInfo = _$AdapterControllerBaseActionController.startAction(
        name: 'AdapterControllerBase.insertAll');
    try {
      return super.insertAll(items);
    } finally {
      _$AdapterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delete(T item) {
    final _$actionInfo = _$AdapterControllerBaseActionController.startAction(
        name: 'AdapterControllerBase.delete');
    try {
      return super.delete(item);
    } finally {
      _$AdapterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void update(T item) {
    final _$actionInfo = _$AdapterControllerBaseActionController.startAction(
        name: 'AdapterControllerBase.update');
    try {
      return super.update(item);
    } finally {
      _$AdapterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
list: ${list}
    ''';
  }
}
