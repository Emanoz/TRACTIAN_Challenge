import 'base_model.dart';

class Checklist extends BaseModel {
  final bool completed;
  final String task;

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