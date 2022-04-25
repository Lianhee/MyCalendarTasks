import 'package:mycalendar/app/data/providers/provider.dart';
import 'package:mycalendar/app/models/project.dart';
import 'package:mycalendar/app/models/task.dart';

class ProjectRepository {
  ProjectProvider projectProvider;
  String username;
  ProjectRepository({required this.projectProvider, required this.username});

  List<Project> readProjects(String username) =>
      projectProvider.readProjects(username);
  void writeProjects(List<Project> projects, String username) =>
      projectProvider.writeProjects(projects, username);
}

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});

  List<Task> readTasks() => taskProvider.readTasks();
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
