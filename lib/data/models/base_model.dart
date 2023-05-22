import 'package:flutter/material.dart';

abstract class BaseModel {
  int? id;

  @protected
  BaseModel.fromJson(Map<String, dynamic> json)
    : id = json['id'];

  @protected
  Map<String, dynamic> toJson();
}