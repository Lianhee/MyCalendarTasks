import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/models/task.dart';
import 'package:mycalendar/app/modules/controller.dart';

class PriorityTasks extends StatelessWidget {
  final ctrl = Get.find<Controller>();
  final int priority;
  final double size;
  PriorityTasks({
    Key? key,
    required this.priority,
    required this.size,
  }) : super(key: key);

  final DateTime now = DateTime.now();
  final TimeOfDay timeNow = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: Obx(() {
          List<Task> tasks = ctrl.getPriorityTasks(priority, now);
          return ListView(
            children: [
              for (int i = 0; i < tasks.length; i += 1)
                if (!tasks[i].done)
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle_outlined,
                          color: tasks[i].project.color,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                            width: size - 40,
                            child: Text(
                              tasks[i].task,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 15),
                            )),
                      ],
                    ),
                  ),
            ],
          );
        }));
  }
}
