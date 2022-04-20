import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/tasks/task_card.dart';

class AllTasksList extends StatefulWidget {
  const AllTasksList({
    Key? key,
  }) : super(key: key);

  @override
  _AllTasksList createState() => _AllTasksList();
}

class _AllTasksList extends State<AllTasksList> {
  Controller ctrl = Get.find<Controller>();
  bool completedTaskView = false;
  List<dynamic> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 162, 103, 172),
          ),
        ),
        title: const Text(
          'Tasks',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 162, 103, 172),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Obx((() {
              tasks = ctrl.allTasks;
              return ListView(
                children: [
                  for (var item in tasks)
                    TaskCard(task: item, homePage: true, padding: 30),
                ],
              );
            }))),
      ),
    );
  }
}
