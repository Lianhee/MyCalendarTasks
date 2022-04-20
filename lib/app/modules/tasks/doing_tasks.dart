import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/tasks/task_card.dart';

class DoingTasks extends StatefulWidget {
  final bool homePage;
  final double padding;

  const DoingTasks({Key? key, required this.homePage, required this.padding})
      : super(key: key);

  @override
  _DoingTasksState createState() => _DoingTasksState();
}

class _DoingTasksState extends State<DoingTasks> {
  final ctrl = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    RxList _items = ctrl.doingTasks;
    return Obx(() => (widget.homePage)
        ? ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
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
                                  child: const Icon(Icons.delete,
                                      color: Colors.white),
                                ),
                                child: ClipRRect(
                                    child: TaskCard(
                                  task: element,
                                  homePage: widget.homePage,
                                  padding: widget.padding,
                                ))))))
                    .toList()
              ])
        : ctrl.doingTasks.isEmpty && ctrl.doneTasks.isEmpty
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
                    final item = _items.removeAt(oldIndex);
                    _items.insert(newIndex, item);
                  });
                },
                children: [
                    for (int index = 0; index < _items.length; index += 1)
                      TaskCard(
                        key: Key('$index'),
                        task: _items[index],
                        homePage: widget.homePage,
                        padding: widget.padding,
                      )
                  ]));
  }
}
