import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/core/values/colors.dart';
import 'package:mycalendar/app/core/values/icons.dart';
import 'package:mycalendar/app/models/project.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/methods/multiple_choice.dart';

void newProject() async {
  final ctrl = Get.find<Controller>();
  final icons = getIcons();
  final iconsData = getIconsData();
  final colors = getHexColors();
  final date = DateTime.now();
  Get.defaultDialog(
    title: 'Create New Project',
    titleStyle: const TextStyle(
      color: Color.fromARGB(255, 104, 103, 172),
    ),
    content: Form(
      key: ctrl.formKey,
      child: SizedBox(
        width: Get.width / 2,
        height: Get.width / 2,
        child: ListView(
          children: [
            TextFormField(
              controller: ctrl.editCtrl,
              decoration: const InputDecoration(
                  //    border: InputBorder.none,
                  labelText: 'Project Title',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(183, 104, 103, 172),
                  )),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter your Project Title';
                  //titleEntered = true;
                }
                return null;
              },
            ),

            /// Choices(multiple: false, choices: icons),
            Wrap(
              children: icons
                  .map((e) => Obx(() {
                        final index = icons.indexOf(e);
                        return ChoiceChip(
                          backgroundColor: Colors.white,
                          selectedColor:
                              const Color.fromARGB(255, 244, 227, 255),
                          label: e,
                          selected: ctrl.iconIndex.value == index,
                          onSelected: (bool selected) async {
                            ctrl.iconIndex.value = selected ? index : 0;
                          },
                        );
                      }))
                  .toList(),
            ),
          ],
        ),
      ),
    ),
    confirm: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: const Color.fromARGB(255, 230, 192, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: const Size(150, 40),
      ),
      onPressed: () async {
        if (ctrl.formKey.currentState!.validate()) {
          int icon = ctrl.iconIndex.value + 1;
          int color = ctrl.iconIndex.value;
          String title = ctrl.editCtrl.text;
          var project = Project(
            title: title,
            icon: iconsData.elementAt(icon),
            color: colors.elementAt(color),
            startDate: date,
            finalDate: date,
            doingTasks: List.empty(growable: true),
            doneTasks: List.empty(growable: true),
          );
          ctrl.addProject(project)
              ? EasyLoading.showSuccess('Project $title created')
              : EasyLoading.showError('Duplicated Project');
          ctrl.editCtrl.clear();
          ctrl.changeIconIndex(0);
          Get.back();
        }
      },
      child: const Text(
        'Continue',
      ),
    ),
  );
  ctrl.editCtrl.clear();
  ctrl.changeIconIndex(0);
}
