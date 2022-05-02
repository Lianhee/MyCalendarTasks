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

  var pageIndex = 0.obs;
  var iconIndex = 0.obs;
  var colorIndex = 0.obs;
  var chooseIndex = 0.obs;
  var choosedIndex = [].obs;

  var projectViewZoom = true.obs;

  var deleting = false.obs;
  var defaultProject = Project(
    title: 'ToDo',
    icon: Icons.create_new_folder_rounded,
    color: const Color.fromARGB(255, 145, 120, 180),
    doingTasks: List.empty(growable: true),
    doneTasks: List.empty(growable: true),
  ).obs;
  var projects = <Project>[].obs;
  var projectsSize = <int>[].obs;
  var projectsDone = <int>[].obs;

  var allTasks = <dynamic>[].obs;
  Rx<Project?> project = Rx(null);

  var doingTasks = <dynamic>[].obs;
  var doneTasks = <dynamic>[].obs;
  String username = '1';

  @override
  void onInit() {
    super.onInit();
    projects.assignAll(projectRepository.readProjects(username));
    ever(projects, (_) => projectRepository.writeProjects(projects, username));
  }

  @override
  void onClose() {
    super.onClose();
    projects = <Project>[].obs;
    projectsSize = <int>[].obs;
    projectsDone = <int>[].obs;

    allTasks = <dynamic>[].obs;
    project = Rx(null);

    doingTasks = <dynamic>[].obs;
    doneTasks = <dynamic>[].obs;
    pageIndex = 0.obs;
    iconIndex = 0.obs;
    colorIndex = 0.obs;
    chooseIndex = 0.obs;
    choosedIndex = [].obs;

    projectViewZoom = true.obs;

    deleting = false.obs;
  }

  void init(String userName) {
    username = userName;
    onInit();
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

  void editTask(Task oldTask, Task newTask) {
    printInfo(info: 'error');
    int index = allTasks.indexOf(oldTask);
    allTasks[index] = newTask;
    allTasks.refresh();
    Project taskProject = oldTask.project;
    index = taskProject.doingTasks.indexOf(oldTask);
    taskProject.doingTasks[index] = newTask;
    if (taskProject == project.value) {
      updateTasksDoneDoing();
    }
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
