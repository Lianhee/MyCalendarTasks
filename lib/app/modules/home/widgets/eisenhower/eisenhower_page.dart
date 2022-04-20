import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/models/task.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/home/widgets/settings/drawer.dart';
import 'package:mycalendar/app/modules/tasks/new_task.dart';
import 'package:mycalendar/app/modules/tasks/task_card.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class EisenhowerPage extends StatefulWidget {
  final int priority;
  const EisenhowerPage({Key? key, required this.priority}) : super(key: key);

  @override
  _EisenhowerPageState createState() => _EisenhowerPageState();
}

class _EisenhowerPageState extends State<EisenhowerPage> {
  Controller ctrl = Get.find<Controller>();
  final width = Get.width;

  final List<Color> colors = [
    Colors.red.shade100,
    Colors.orange.shade100,
    Colors.green.shade100,
    Colors.blue.shade100
  ];

  final List<Color> shadowColors = [
    Colors.red.shade200,
    Colors.orange.shade200,
    Colors.green.shade200,
    Colors.blue.shade200
  ];

  final List<IconData> priorityIcons = [
    Icons.looks_one,
    Icons.looks_two,
    Icons.looks_3,
    Icons.looks_4
  ];

  final List<String> priorityTitle = [
    'Urgent & Important',
    'Not Urgent & Important',
    'Urgent & Not Important',
    'Not Urgent & Not Important',
  ];

  final DateTime now = DateTime.now();

  bool taskView = true;
  bool completedTaskView = true;

  @override
  Widget build(BuildContext context) {
    final priority = widget.priority;
    final color = colors[priority];

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
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: Color.fromARGB(255, 162, 103, 172),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: color.withOpacity(0.6))),
                          child: IconButton(
                            onPressed: () async {},
                            icon: const Icon(
                              Icons.edit,
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
                            priorityIcons[priority],
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
                          child: Text(priorityTitle[priority],
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
                        final List<int> prioritySize =
                            ctrl.getPriorityStep(priority, now);
                        final done = prioritySize[0];
                        final total = prioritySize[1];
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
                    taskView = !taskView;
                  });
                },
                child: Row(children: [
                  Text(
                    'Tasks To Do',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(
              width: width - 40,
              height: width,
              child: tasksList(priority),
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
                child: NewTask(
                  priority: priority,
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

  tasksList(int priority) {
    return Obx(() {
      List<Task> priorityTasks = ctrl.getPriorityTasks(priority, now);
      List<Task> doneTasks = [];
      List<Task> doingTasks = [];

      for (int i = 0; i < priorityTasks.length; i++) {
        Task task = priorityTasks[i];
        if (task.done) {
          doneTasks.add(task);
        } else {
          doingTasks.add(task);
        }
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: (doingTasks.isEmpty && doneTasks.isEmpty)
                  ? const Padding(
                      padding: EdgeInsets.only(
                        left: 7,
                        top: 10,
                      ),
                      child: Text(
                        'There are not ongoing tasks',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          //fontSize: 15,
                          color: Colors.grey,
                        ),
                      ))
                  : ReorderableListView(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      onReorder: (int oldIndex, int newIndex) {
                        setState(() {
                          final item = doingTasks.removeAt(oldIndex);
                          doingTasks.insert(newIndex, item);
                        });
                      },
                      children: [
                          for (int index = 0;
                              index < doingTasks.length;
                              index += 1)
                            TaskCard(
                              key: Key('$index'),
                              task: doingTasks[index],
                              homePage: false,
                              padding: 15,
                            )
                        ])),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: (doingTasks.isEmpty && doneTasks.isEmpty)
                ? const Padding(padding: EdgeInsets.zero)
                : Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 5,
                    ),
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          completedTaskView = !completedTaskView;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Completed (${doneTasks.length})',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade900,
                              ),
                            ),
                            (completedTaskView)
                                ? ListView(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    children: [
                                        for (int index = 0;
                                            index < doneTasks.length;
                                            index += 1)
                                          TaskCard(
                                            key: Key('$index'),
                                            task: doneTasks[index],
                                            homePage: false,
                                            padding: 15 + 20,
                                          )
                                      ])
                                : const Padding(padding: EdgeInsets.zero)
                          ]),
                    ),
                  ),
          ),
        ],
      );
    });
  }
}
