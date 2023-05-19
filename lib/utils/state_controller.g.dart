// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StateController<T> on StateControllerBase<T>, Store {
  late final _$currentValueAtom =
      Atom(name: 'StateControllerBase.currentValue', context: context);

  @override
  T get currentValue {
    _$currentValueAtom.reportRead();
    return super.currentValue;
  }

  @override
  set currentValue(T value) {
    _$currentValueAtom.reportWrite(value, super.currentValue, () {
      super.currentValue = value;
    });
  }

  late final _$StateControllerBaseActionController =
      ActionController(name: 'StateControllerBase', context: context);

  @override
  void setValueState(T state) {
    final _$actionInfo = _$StateControllerBaseActionController.startAction(
        name: 'StateControllerBase.setValueState');
    try {
      return super.setValueState(state);
    } finally {
      _$StateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentValue: ${currentValue}
    ''';
  }
}
