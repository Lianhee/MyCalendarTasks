import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/models/project.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/home/widgets/settings/drawer.dart';
import 'package:mycalendar/app/modules/tasks/doing_tasks.dart';
import 'package:mycalendar/app/modules/tasks/done_task.dart';
import 'package:mycalendar/app/modules/tasks/new_task.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ProjectWindow extends StatefulWidget {
  const ProjectWindow({Key? key}) : super(key: key);

  @override
  _ProjectWindowState createState() => _ProjectWindowState();
}

class _ProjectWindowState extends State<ProjectWindow> {
  final ctrl = Get.find<Controller>();
  final width = Get.width;

  bool projectDetailsView = false;
  bool projectTasksView = true;

  @override
  Widget build(BuildContext context) {
    Project project = ctrl.project.value!;
    final title = project.title;
    final icon = project.icon;
    final color = project.color;
    return Scaffold(
      drawer: const MenuPage(),
      backgroundColor: const Color.fromARGB(255, 255, 249, 249),
      resizeToAvoidBottomInset: true,
      // drawer: const MenuPage(),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              color: color.withOpacity(0.5),
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: color.withOpacity(0.6))),
                          child: IconButton(
                            onPressed: () async {
                              ctrl.editCtrl.clear();
                              ctrl.changeProject(ctrl.defaultProject.value);
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: Color.fromARGB(255, 162, 103, 172),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                          ),
                          child: Icon(
                            icon,
                            color: Colors.blueGrey.shade900,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: width * 0.75,
                            maxHeight: 40,
                          ),
                          child: Text(title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(
                      () {
                        final done = ctrl.doneTasks.length;
                        final total =
                            ctrl.doingTasks.length + ctrl.doneTasks.length;
                        return Column(
                          children: [
                            StepProgressIndicator(
                              totalSteps: total == 0 ? 100 : total,
                              currentStep: done,
                              size: 3,
                              padding: 0,
                              selectedGradientColor: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  end: Alignment.topLeft,
                                  colors: [
                                    color,
                                    color,
                                  ]
                                  //colors: [Color(color).withOpacity(0.5), Color(color)],
                                  ),
                              unselectedColor: Colors.blueGrey.shade50,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Progress $done / $total',
                                    textAlign: TextAlign.start,
                                    // minFontSize: 12,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 141, 128, 143)),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${total == 0 ? 0 : (done / total * 100).round()}%',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 141, 128, 143)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () async {
                  setState(() {
                    projectTasksView = !projectTasksView;
                  });
                },
                child: Row(children: [
                  Text(
                    'Tasks List',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 15,
                    child: Icon(Icons.arrow_drop_down_rounded),
                  ),
                ]),
              ),
            ),
            SizedBox(
              width: width - 40,
              height: width,
              child: (projectTasksView)
                  ? tasksList(project)
                  : const Padding(padding: EdgeInsets.zero),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color,
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const NewTask(
                  priority: 5,
                ),
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  tasksList(Project project) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: DoingTasks(
            homePage: false,
            padding: 15,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: DoneTasks(
            homePage: false,
            padding: 15,
          ),
        ),
      ],
    );
  }
}
