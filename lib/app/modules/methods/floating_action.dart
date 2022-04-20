import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/models/project.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/tasks/new_task.dart';

class FloatingAction extends StatelessWidget {
  FloatingAction({Key? key}) : super(key: key);
  final Controller ctrl = Get.find<Controller>();
  @override
  Widget build(BuildContext context) {
    return DragTarget<Project>(
      builder: (_, __, ___) {
        return Obx(
          () => FloatingActionButton(
            backgroundColor: ctrl.deleting.value
                ? const Color.fromARGB(255, 252, 175, 175)
                : const Color.fromARGB(255, 204, 175, 252),
            onPressed: () async {
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
                    child: const NewTask(
                      priority: 5,
                    ),
                  ),
                ),
              );
            },
            child: Icon(
              ctrl.deleting.value ? Icons.delete : Icons.add,
            ),
          ),
        );
      },
      onAccept: (Project project) {
        String title = project.title;
        EasyLoading.showSuccess('Projet "$title" deleted');
        ctrl.deleteProject(project);
      },
    );
  }
}
