import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/core/values/colors.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/home/widgets/eisenhower/eisenhower_page.dart';
import 'package:mycalendar/app/modules/tasks/priority_tasks.dart';

class EisenhowerView extends StatefulWidget {
  const EisenhowerView({Key? key}) : super(key: key);

  @override
  _EisenhowerViewState createState() => _EisenhowerViewState();
}

class _EisenhowerViewState extends State<EisenhowerView> {
  Controller ctrl = Get.find<Controller>();

  final List<Color> colors = [
    Colors.red.shade100,
    Colors.orange.shade100,
    Colors.green.shade100,
    Colors.blue.shade100
  ];
  final List<Color> shadowColors = getPriorityColors();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 5,
            left: 5,
          ),
          child: priorityBox(priority: 0),
        ),
        Padding(
            padding: const EdgeInsets.only(
              top: 5,
              left: 10,
              right: 5,
            ),
            child: priorityBox(priority: 1)),
      ]),
      Row(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 5,
          ),
          child: priorityBox(priority: 2),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 10,
            right: 5,
          ),
          child: priorityBox(priority: 3),
        ),
      ]),
    ]);
  }

  priorityBox({required int priority}) {
    final size = Get.width;
    return Container(
      width: size / 2 - 15,
      height: size / 2 - 15,
      decoration: BoxDecoration(
          color: colors[priority],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: shadowColors[priority],
              offset: const Offset(3, 4),
              blurRadius: 2,
            ),
          ]),
      child: InkWell(
        onTap: () async {
          Get.to(() => EisenhowerPage(priority: priority));
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: PriorityTasks(
            priority: priority,
            size: size / 2 - 20,
          ),
        ),
      ),
    );
  }
}
