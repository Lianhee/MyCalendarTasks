import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/core/values/icons.dart';
import 'package:mycalendar/app/models/task.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/methods/days.dart';
import 'package:mycalendar/app/modules/tasks/edit_task.dart';

// ignore: must_be_immutable
class TaskCard extends StatelessWidget {
  final ctrl = Get.find<Controller>();
  final Task task;
  final bool homePage;
  final double padding;

  TaskCard({
    Key? key,
    required this.task,
    required this.homePage,
    required this.padding,
  }) : super(key: key);

  final DateTime now = DateTime.now();
  final TimeOfDay timeNow = TimeOfDay.now();
  Color color = const Color.fromARGB(255, 145, 120, 180);

  final icons = getIconsData();

  @override
  Widget build(BuildContext context) {
    color = task.project.color;
    final width = Get.width - padding;
    return Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 2,
                  offset: const Offset(2, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Dismissible(
                key: ObjectKey(task),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => ctrl.deleteTask(task),
                background: Container(
                  color: color.withOpacity(0.5),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: InkWell(
                  onTap: () async {
                    await showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: EditTask(task: task),
                        ),
                      ),
                    );
                    EditTask(task: task);
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: Checkbox(
                              shape: const CircleBorder(),
                              fillColor: MaterialStateProperty.resolveWith(
                                  ((states) => (task.done)
                                      ? color.withOpacity(0.5)
                                      : color)),
                              value: task.done,
                              onChanged: (bool? value) {
                                if (value != null) {
                                  ctrl.changeTaskStatus(task, value);
                                }
                              },
                            ),
                          ),
                          Container(
                            width: width - 55,
                            constraints: const BoxConstraints(
                              maxHeight: 40,
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: (task.done)
                                    ? Text(
                                        task.task,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      )
                                    : Text(
                                        task.task,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                          ),
                        ],
                      ),
                      Container(
                        constraints: const BoxConstraints(
                          maxHeight: 40,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            bottom: 5,
                          ),
                          child: addTaskDetails(width: width - 40),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }

  addTaskDetails({required double width}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        (task.dueDate == null)
            ? const Padding(padding: EdgeInsets.zero)
            : Container(
                constraints: BoxConstraints(
                  maxWidth: width / 3,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: (Days.diffDays(now: now, date: task.dueDate!) < 0)
                          ? Colors.red
                          : color,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      Days.format.format(task.dueDate as DateTime),
                      // minFontSize: 12,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
        (task.repeat == null)
            ? const Padding(padding: EdgeInsets.zero)
            : Container(
                constraints: const BoxConstraints(
                  maxWidth: 15,
                  //minWidth: 10,
                ),
                child: Icon(
                  Icons.repeat,
                  color: color,
                  size: 15,
                ),
              ),
        (task.remindDateTime == null)
            ? const Padding(padding: EdgeInsets.zero)
            : Container(
                constraints: const BoxConstraints(
                  maxWidth: 10,
                  //minWidth: 10,
                ),
                child: Icon(
                  Icons.alarm,
                  color: color,
                  size: 15,
                ),
              ),
        const Spacer(),
        (homePage)
            ? Container(
                constraints: BoxConstraints(
                  maxWidth: Get.width / 3,
                  //minWidth: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      task.project.title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      // minFontSize: 12,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      task.project.icon,
                      color: color,
                      size: 20,
                    ),
                  ],
                ),
              )
            : const Padding(padding: EdgeInsets.zero),
      ],
    );
  }
}
