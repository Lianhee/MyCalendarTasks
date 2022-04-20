import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/tasks/task_card.dart';

class DoneTasks extends StatefulWidget {
  final bool homePage;
  final double padding;

  const DoneTasks({Key? key, required this.homePage, required this.padding})
      : super(key: key);

  @override
  _DoneTasksState createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
  bool completedTasksView = false;
  final ctrl = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    RxList _items = ctrl.doneTasks;
    return Obx(() => (widget.homePage)
        ? Column(children: [
            ...ctrl.doingTasks
                .map((element) => Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 5,
                      bottom: 5,
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Dismissible(
                            key: ObjectKey(element),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) => ctrl.deleteTask(element),
                            background: Container(
                              color: element.project.color,
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: ClipRRect(
                                child: TaskCard(
                              task: element,
                              homePage: widget.homePage,
                              padding: widget.padding,
                            ))))))
                .toList()
          ])
        : Column(
            children: [
              ctrl.doingTasks.isEmpty && ctrl.doneTasks.isEmpty
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
                            completedTasksView = !completedTasksView;
                          });
                        },
                        child: Row(children: [
                          Text(
                            'Completed (${ctrl.doneTasks.length})',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey.shade900,
                            ),
                          ),
                        ]),
                      ),
                    ),
              (completedTasksView)
                  ? (ctrl.doneTasks.isEmpty)
                      ? const Padding(
                          padding: EdgeInsets.only(
                            left: 7,
                            top: 10,
                          ),
                          child: Text(
                            'There are not completed tasks',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              //fontSize: 15,
                              color: Colors.grey,
                            ),
                          ))
                      : ListView(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          children: [
                              for (int index = 0;
                                  index < _items.length;
                                  index += 1)
                                TaskCard(
                                  key: Key('$index'),
                                  task: _items[index],
                                  homePage: widget.homePage,
                                  padding: widget.padding + 20,
                                )
                            ])
                  : const Padding(padding: EdgeInsets.zero)
            ],
          ));
  }
}
