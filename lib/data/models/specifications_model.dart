import 'package:tractian_app/data/models/base_model.dart';

class Specifications extends BaseModel {
  final int maxTemp;
  final double? power;
  final int? rpm;

  Specifications(this.maxTemp, this.power, this.rpm) : super.fromJson({});

  Specifications.fromJson(Map<String, dynamic> json)
      : maxTemp = json['maxTemp'],
        power = double.tryParse(json['power'].toString()),
        rpm = json['rpm'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
    'maxTemp': maxTemp,
    'power': power,
    'rpm': rpm,
  };
}