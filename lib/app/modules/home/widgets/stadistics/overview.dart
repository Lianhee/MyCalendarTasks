import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/stadistics/priority_stadistics.dart';
import 'package:mycalendar/app/modules/stadistics/view.dart';

class OverviewWindow extends StatefulWidget {
  const OverviewWindow({
    Key? key,
  }) : super(key: key);

  @override
  _OverviewWindowState createState() => _OverviewWindowState();
}

class _OverviewWindowState extends State<OverviewWindow> {
  final homeCtrl = Get.find<Controller>();
  final DateTime now = DateTime.now();
  int todoSize = 0;
  int doneSize = 0;
  String text = '';

  final List<Color> colors = [
    Colors.red.shade200,
    Colors.orange.shade200,
    Colors.green.shade200,
    Colors.blue.shade200
  ];
  final List<String> priorityTitle = [
    'Urgent & Important',
    'Not Urgent & Important',
    'Urgent & Not Important',
    'Not Urgent & Not Important',
  ];

  @override
  Widget build(BuildContext context) {
    int todo = 0;
    int done = 0;
    bool empty = true;
    List<List<int>> sizes = [];
    for (int i = 0; i < 4; i++) {
      List<int> size = homeCtrl.getPriorityStep(i, now);
      sizes.add(size);
      todo += size[1];
      done += size[0];
      if (done > 0) {
        empty = false;
      }
    }

    setState(() {
      todoSize = todo;
      doneSize = done;
    });
    if (todoSize == 0) {
      text = 'Today you do not have tasks to do';
    } else {
      if (doneSize == todoSize) {
        text = 'You have completed all tasks!!';
      } else {
        text = 'Today you have done $doneSize of $todoSize tasks';
      }
    }

    return Container(
        height: Get.height / 3,
        width: Get.width - 10 - 10,
        decoration: BoxDecoration(
          color: Colors.purple.shade100,
          boxShadow: [
            BoxShadow(
              color: Colors.purple.shade200,
              offset: const Offset(3, 4),
              blurRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
            onTap: (() {
              homeCtrl.pageIndex.value = 1;
              Get.to(() => const StadisticsPage());
            }),
            child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 15,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 162, 103, 172),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    getPriorityProgress(
                        sizes: sizes,
                        isEmpty: empty,
                        colors: colors,
                        titles: priorityTitle),
                  ],
                ))));
  }
}
