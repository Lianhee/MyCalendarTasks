import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mycalendar/app/models/task.dart';

// ignore: must_be_immutable
class Project extends Equatable {
  final String title;
  final IconData icon;
  final Color color;
  final DateTime? startDate;
  final DateTime? finalDate;
  final String? notes;
  List<Task> doneTasks;
  List<Task> doingTasks;
  Project({
    required this.title,
    required this.icon,
    required this.color,
    this.startDate,
    this.finalDate,
    this.notes,
    required this.doneTasks,
    required this.doingTasks,
  });

  // Project copyWith({
  //   String? title,
  //   IconData? icon,
  //   Color? color,
  //   DateTime? startDate,
  //   DateTime? finalDate,
  //   String? notes,
  //   List<dynamic>? doneTasks,
  //   List<dynamic>? doingTasks,
  // }) {
  //   return Project(
  //     title: title ?? this.title,
  //     icon: icon ?? this.icon,
  //     color: color ?? this.color,
  //     startDate: startDate ?? this.startDate,
  //     finalDate: finalDate ?? this.finalDate,
  //     notes: notes ?? this.notes,
  //     doneTasks: doneTasks ?? this.doneTasks,
  //     doingTasks: doingTasks ?? this.doingTasks,
  //   );
  // }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'],
      icon: json['icon'],
      color: json['color'],
      doingTasks: json['tasks'], doneTasks: json['doneTasks'],
      // startDate: json['startDate'],
      // finalDate: json['finalDate'],
    );
  }

  Map<String, dynamic> toJson(Project project) => {
        'title': project.title,
        'icon': project.icon,
        'color': project.color,
        'tasks': doneTasks,
      };

  @override
  List<Object?> get props => [title, icon, color];
}
