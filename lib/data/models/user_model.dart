import 'package:flutter/material.dart';
import 'package:tractian_app/data/models/base_model.dart';

class User extends BaseModel{
  final int companyId;
  final String email;
  final String name;
  final int unitId;

  User(this.unitId, this.companyId, this.email, this.name) : super.fromJson({});

  User.fromJson(Map<String, dynamic> json)
      : companyId = json['companyId'],
        email = json['email'],
        name = json['name'],
        unitId = json['unitId'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'companyId': companyId,
    'email': email,
    'name': name,
    'unitId': unitId,
  };
}