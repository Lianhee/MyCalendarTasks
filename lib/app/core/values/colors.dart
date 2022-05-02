import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/models/project.dart';
import 'package:mycalendar/app/modules/controller.dart';

List<Color> getColors() {
  return [
    Colors.amber.shade200,
    Colors.yellow.shade300,
    Colors.blueGrey.shade200,
    Colors.cyan.shade200,
    Colors.deepOrange.shade200,
    Colors.deepPurple.shade200,
    Colors.teal.shade200,
    Colors.indigo.shade200,
    Colors.lightBlue.shade200,
    Colors.lightGreen.shade200,
    Colors.pink.shade200,
    Colors.purple.shade200,
  ];
}

List<Widget> getWidgetColors() {
  final colors = getColors();
  return [
    for (int i = 0; i < colors.length; i++)
      Container(
        color: colors[i],
        width: 20,
        height: 20,
      ),
  ];
}

List<Color> getPriorityColors() {
  return [
    Colors.red.shade200,
    Colors.orange.shade200,
    Colors.green.shade200,
    Colors.blue.shade200
  ];
}

// Theme Color select
Color chooseColor(Project? selected) {
  Controller ctrl = Get.find<Controller>();
  return (ctrl.project.value == null)
      ? (selected == null)
          ? const Color.fromARGB(255, 145, 120, 180)
          : selected.color
      : (selected == null)
          ? ctrl.project.value!.color
          : selected.color;
}
