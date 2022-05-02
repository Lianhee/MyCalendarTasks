import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/core/values/colors.dart';
import 'package:mycalendar/app/core/values/icons.dart';
import 'package:mycalendar/app/models/project.dart';
import 'package:mycalendar/app/modules/controller.dart';

void newProject() async {
  final ctrl = Get.find<Controller>();
  final icons = getIcons();
  final iconsData = getIconsData();
  final colors = getWidgetColors();
  final colorsData = getColors();
  final date = DateTime.now();
  Get.defaultDialog(
    title: 'Create New Project',
    titleStyle: const TextStyle(
      color: Color.fromARGB(255, 104, 103, 172),
    ),
    content: Form(
      key: ctrl.formKey,
      child: SizedBox(
        width: Get.width,
        height: Get.width / 2,
        child: SafeArea(
          child: ListView(
            children: [
              TextFormField(
                controller: ctrl.editCtrl,
                decoration: const InputDecoration(
                    labelText: 'Project Title',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(183, 104, 103, 172),
                    )),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter your Project Title';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Wrap(
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Wrap(
                  children: colors
                      .map((e) => Obx(() {
                            final index = colors.indexOf(e);
                            return ChoiceChip(
                              backgroundColor: Colors.white,
                              selectedColor:
                                  const Color.fromARGB(255, 244, 227, 255),
                              label: e,
                              selected: ctrl.colorIndex.value == index,
                              onSelected: (bool selected) async {
                                ctrl.colorIndex.value = selected ? index : 0;
                              },
                            );
                          }))
                      .toList(),
                ),
              ),
            ],
          ),
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
          int icon = ctrl.iconIndex.value;
          int color = ctrl.colorIndex.value;
          String title = ctrl.editCtrl.text;
          var project = Project(
            title: title,
            icon: iconsData.elementAt(icon),
            color: colorsData.elementAt(color),
            startDate: date,
            finalDate: date,
            doingTasks: List.empty(growable: true),
            doneTasks: List.empty(growable: true),
          );
          ctrl.addProject(project)
              ? EasyLoading.showSuccess('Project $title created')
              : EasyLoading.showError('Duplicated Project');
          ctrl.editCtrl.clear();
          ctrl.colorIndex.value = 0;
          ctrl.iconIndex.value = 0;
          Get.back();
        }
      },
      child: const Text(
        'Continue',
      ),
    ),
  );
  ctrl.editCtrl.clear();
  ctrl.iconIndex.value = 0;
  ctrl.colorIndex.value = 0;
}
