import 'package:mycalendar/app/data/providers/provider.dart';
import 'package:mycalendar/app/models/project.dart';
import 'package:mycalendar/app/models/task.dart';

class ProjectRepository {
  ProjectProvider projectProvider;
  ProjectRepository({required this.projectProvider});

  List<Project> readProjects() => projectProvider.readProjects();
  void writeProjects(List<Project> projects) =>
      projectProvider.writeProjects(projects);
}

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});

  List<Task> readTasks() => taskProvider.readTasks();
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
