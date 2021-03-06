import 'package:get/get.dart';
import 'package:mycalendar/app/core/utils/keys.dart';
import 'package:mycalendar/app/data/services/services.dart';
import 'package:mycalendar/app/models/project.dart';
import 'package:mycalendar/app/models/task.dart';

class ProjectProvider {
  //var privada
  final StorageService _storageService = Get.find<StorageService>();

  ProjectProvider();

  List<Project> readProjects(String username) {
    var projects = <Project>[];
    _storageService.read(username + projectKey).forEach((e) => projects.add(e));
    return projects;
  }

  void writeProjects(List<Project> projects, String username) {
    _storageService.write(
      username + projectKey,
      projects,
    );
  }
}

class TaskProvider {
  //var privada
  final StorageService _storageService = Get.find<StorageService>();

  List<Task> readTasks() {
    var tasks = <Task>[];
    _storageService.read(projectKey).forEach((e) => tasks.add(e));
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storageService.write(taskKey, tasks);
  }
}
