import 'package:equatable/equatable.dart';
import 'package:mycalendar/app/models/project.dart';

class Task extends Equatable {
  final String task;
  final bool done;
  final Project project;
  final DateTime? dueDate;
  final DateTime? remindDateTime;
  final MapEntry<int?, String>? repeat;
  final List<bool>? repeatEvery;
  final DateTime? repeatDate;
  final int priority;
  const Task({
    required this.task,
    required this.done,
    required this.project,
    this.dueDate,
    this.remindDateTime,
    this.repeat,
    this.repeatEvery,
    this.repeatDate,
    required this.priority,
  });

  Task copyWith({
    String? task,
    bool? done,
    Project? project,
    DateTime? dueDate,
    DateTime? remindDateTime,
    MapEntry<int?, String>? repeat,
    List<bool>? repeatEvery,
    DateTime? repeatDate,
    int? priority,
  }) {
    return Task(
      task: task ?? this.task,
      done: done ?? this.done,
      project: project ?? this.project,
      dueDate: dueDate ?? this.dueDate,
      remindDateTime: remindDateTime ?? this.remindDateTime,
      repeat: repeat ?? this.repeat,
      repeatEvery: repeatEvery ?? this.repeatEvery,
      repeatDate: repeatDate ?? this.repeatDate,
      priority: priority ?? this.priority,
    );
  }

  @override
  List<Object?> get props => [
        task,
        done,
      ];
}
