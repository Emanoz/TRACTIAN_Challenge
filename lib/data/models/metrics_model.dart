import 'base_model.dart';

class Metrics extends BaseModel {
  final String lastUptimeAt;
  final int totalCollectsUptime;
  final double totalUptime;

  Metrics(this.lastUptimeAt, this.totalCollectsUptime, this.totalUptime) : super.fromJson({});

  Metrics.fromJson(Map<String, dynamic> json)
      : lastUptimeAt = json['lastUptimeAt'],
        totalCollectsUptime = json['totalCollectUptime'],
        totalUptime = json['totalUptime'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
    'lastUptimeAt': lastUptimeAt,
    'totalCollectsUptime': totalCollectsUptime,
    'totalUptime': totalUptime,
  };
}