import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/data/services/repository.dart';
import 'package:mycalendar/app/models/project.dart';
import 'package:mycalendar/app/models/task.dart';
import 'package:mycalendar/app/modules/methods/days.dart';

class Controller extends GetxController {
  ProjectRepository projectRepository;
  Controller({required this.projectRepository});

  //Global Key
  GlobalKey globalKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final editCtrl = TextEditingController();

  // Task Key
  final taskFormKey = GlobalKey<FormState>();
  final taskEditCtrl = TextEditingController();

  final pageIndex = 0.obs;
  final iconIndex = 0.obs;
  final colorIndex = 0.obs;
  final chooseIndex = 0.obs;
  final choosedIndex = [].obs;

  final projectViewZoom = true.obs;

  final deleting = false.obs;
  var defaultProject = Project(
    title: 'ToDo',
    icon: Icons.create_new_folder_rounded,
    color: const Color.fromARGB(255, 145, 120, 180),
    doingTasks: List.empty(growable: true),
    doneTasks: List.empty(growable: true),
  ).obs;
  final projects = <Project>[].obs;
  final projectsSize = <int>[].obs;
  final projectsDone = <int>[].obs;

  final allTasks = <dynamic>[].obs;
  final Rx<Project?> project = Rx(null);

  final doingTasks = <dynamic>[].obs;
  final doneTasks = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    projects.assignAll(projectRepository.readProjects());
    ever(projects, (_) => projectRepository.writeProjects(projects));
  }

  @override
  void onClose() {
    super.onClose();
  }

//Index
  void changeIconIndex(int value) {
    iconIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

//Projects
  bool addProject(Project project) {
    if (projects.contains(project)) {
      return false;
    }
    projects.add(project);
    return true;
  }

  void changeProject(Project selected) {
    project.value = selected;
    updateTasksDoneDoing();
  }

  void updateTasksDoneDoing() {
    doneTasks.clear();
    doingTasks.clear();
    Project projectValue = project.value!;
    if (projectValue.doneTasks.isNotEmpty) {
      doneTasks.addAll(projectValue.doneTasks);
    }
    if (projectValue.doingTasks.isNotEmpty) {
      doingTasks.addAll(projectValue.doingTasks);
    }
    doneTasks.refresh();
    doingTasks.refresh();
  }

  void deleteProject(Project project) {
    project.doneTasks.clear();
    project.doingTasks.clear();
    projects.remove(project);
  }

  bool addTask(Task task) {
    Project taskProject = task.project;
    if (taskProject == project.value) {
      doingTasks.add(task);
      doingTasks.refresh();
    }
    updateTasks(task);
    allTasks.add(task);
    printInfo(info: '${allTasks.length}');
    allTasks.refresh();
    return true;
  }

  void updateTasks(Task task) {
    if (task.done) {
      task.project.doneTasks.add(task);
    } else {
      task.project.doingTasks.add(task);
    }

    projects.refresh();
  }

  void changeTaskStatus(Task task, bool isDone) {
    Task newTask = task.copyWith(done: isDone);
    updateDoingTasks(task, newTask);
  }

  void updateDoingTasks(Task task, Task newTask) {
    Project taskProject = task.project;
    bool isDone = newTask.done;
    int index = allTasks.indexOf(task);
    allTasks[index] = newTask;
    if (isDone) {
      taskProject.doingTasks.remove(task);
      taskProject.doneTasks.add(newTask);
    } else {
      taskProject.doneTasks.remove(task);
      taskProject.doingTasks.add(newTask);
    }
    if (taskProject == project.value) {
      updateTasksDoneDoing();
    }
    projects.refresh();
    allTasks.refresh();
  }

  void deleteTask(Task task) {
    Project taskProject = task.project;
    bool isDone = task.done;
    if (isDone) {
      taskProject.doneTasks.remove(task);
    } else {
      taskProject.doingTasks.remove(task);
    }
    if (project.value == taskProject) {
      updateTasksDoneDoing();
    }
    allTasks.remove(task);
    allTasks.refresh();
  }

  List<String> getProjectsTitle() {
    List<String> titles = [];
    titles.add(defaultProject.value.title);
    for (int i = 0; i < projects.length; i++) {
      titles.add(projects[i].title);
    }
    return titles;
  }

  List<List<int>> getProjectsDoneTasks() {
    List<List<int>> list = [];
    list.add([
      defaultProject.value.doneTasks.length,
      defaultProject.value.doneTasks.length +
          defaultProject.value.doingTasks.length
    ]);
    for (int i = 0; i < projects.length; i++) {
      list.add([
        projects[i].doneTasks.length,
        projects[i].doneTasks.length + projects[i].doingTasks.length
      ]);
    }
    return list;
  }

  List<Task> getTotalTasks() {
    List<Task> tasks = [];
    for (int i = 0; i < projects.length; i++) {
      if (projects[i].doneTasks.isNotEmpty) {
        tasks.addAll(
          projects[i].doneTasks,
        );
      }
      if (projects[i].doingTasks.isNotEmpty) {
        tasks.addAll(
          projects[i].doingTasks,
        );
      }
    }
    if (defaultProject.value.doneTasks.isNotEmpty) {
      tasks.addAll(
        defaultProject.value.doneTasks,
      );
    }
    if (defaultProject.value.doingTasks.isNotEmpty) {
      tasks.addAll(
        defaultProject.value.doingTasks,
      );
    }
    return tasks;
  }

  List<Task> getDayTasks(DateTime date, List tasks) {
    List<Task> dayTasks = [];
    for (int i = 0; i < tasks.length; i++) {
      Task task = tasks[i];
      if (task.dueDate != null &&
          Days.diffDays(now: task.dueDate!, date: date) == 0) {
        dayTasks.add(task);
      } else if (task.remindDateTime != null &&
          Days.diffDays(now: task.remindDateTime!, date: date) == 0) {
        dayTasks.add(task);
      }
    }
    return dayTasks;
  }

  List<int> getPriorityStep(int priority, DateTime? day) {
    int doneTasks = 0;
    List<Task> priorityTasks = getPriorityTasks(priority, day);
    for (int i = 0; i < priorityTasks.length; i++) {
      if (priorityTasks[i].done) {
        doneTasks += 1;
      }
    }
    return [doneTasks, priorityTasks.length];
  }

  List<Task> getPriorityTasks(int priority, DateTime? day) {
    List<Task> tasks = getTotalTasks();
    List<Task> tasksPriority = [];

    if (day != null) {
      for (int i = 0; i < tasks.length; i++) {
        if (tasks[i].priority == priority) {
          if (tasks[i].dueDate == null ||
              tasks[i].dueDate != null &&
                  Days.diffDays(now: day, date: tasks[i].dueDate!) == 0) {
            tasksPriority.add(tasks[i]);
          }
        }
      }
    } else {
      for (int i = 0; i < tasks.length; i++) {
        if (tasks[i].priority == priority) {
          tasksPriority.add(tasks[i]);
        }
      }
    }
    return tasksPriority;
  }

  getDone({required Project project}) {
    return project.doneTasks.length;
  }

  getSize({required Project project}) {
    return project.doneTasks.length + project.doingTasks.length;
  }

  void updateProjectView() {
    projectViewZoom.value = !projectViewZoom.value;
  }
}
