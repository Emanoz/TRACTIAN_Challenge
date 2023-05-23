import 'base_model.dart';

class Checklist extends BaseModel {
  late bool completed;
  late String task;

  Checklist(this.completed, this.task) : super.fromJson({});

  Checklist.fromJson(Map<String, dynamic> json)
      : completed = json['completed'],
        task = json['task'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
    'completed': completed,
    'task': task,
  };
}