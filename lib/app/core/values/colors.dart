import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/models/project.dart';
import 'package:mycalendar/app/modules/controller.dart';

List<Color> getColors() {
  return const [
    Color.fromARGB(255, 255, 253, 222),
    Color.fromARGB(255, 255, 249, 249),
    Color.fromARGB(255, 255, 239, 239),
    Color.fromARGB(255, 255, 203, 203),
    Color.fromARGB(255, 255, 188, 209),
    Color.fromARGB(255, 231, 251, 190),
    Color.fromARGB(255, 215, 127, 161),
    Color.fromARGB(255, 214, 229, 250),
    Color.fromARGB(255, 211, 222, 220),
    Color.fromARGB(255, 206, 123, 176),
    Color.fromARGB(255, 186, 171, 218),
    Color.fromARGB(255, 185, 131, 255),
    Color.fromARGB(255, 162, 103, 172), //Text
    Color.fromARGB(255, 146, 169, 189),
    Color.fromARGB(255, 124, 153, 172),
    Color.fromARGB(255, 104, 103, 172), // Default
    Color.fromARGB(48, 104, 103, 172), //sombra
    Color.fromARGB(151, 104, 103, 172), //text in sombre
  ];
}

List<Widget> getWidgetColors() {
  return [
    // Container(
    //   color: const Color.fromARGB(255, 255, 253, 222),
    //   width: 20,
    //   height: 20,
    // ),
    // Container(
    //   color: const Color.fromARGB(255, 255, 249, 249),
    //   width: 20,
    //   height: 20,
    // ),
    Container(
      color: const Color.fromARGB(255, 255, 239, 239),
      width: 10,
      height: 30,
    ),
    Container(
      color: const Color.fromARGB(255, 255, 203, 203),
      width: 10,
      height: 30,
    ),
    Container(
      color: const Color.fromARGB(255, 255, 188, 209),
      width: 10,
      height: 30,
    ),
    Container(
      color: const Color.fromARGB(255, 231, 251, 190),
      width: 10,
      height: 30,
    ),
    Container(
      color: const Color.fromARGB(255, 215, 127, 161),
      width: 10,
      height: 30,
    ),
    Container(
      color: const Color.fromARGB(255, 214, 229, 250),
      width: 10,
      height: 30,
    ),
    Container(
      color: const Color.fromARGB(255, 211, 222, 220),
      width: 10,
      height: 30,
    ),
    Container(
      color: const Color.fromARGB(255, 206, 123, 176),
      width: 10,
      height: 30,
    ),
    Container(
      color: const Color.fromARGB(255, 186, 171, 218),
      width: 10,
      height: 30,
    ),
    Container(
      color: const Color.fromARGB(255, 185, 131, 255),
      width: 10,
      height: 30,
    ),
    Container(
      color: const Color.fromARGB(255, 162, 103, 172),
      width: 10,
      height: 30,
    ),
    Container(
      color: const Color.fromARGB(255, 146, 169, 189),
      width: 10,
      height: 30,
    ),
    // Container(
    //   color: const Color.fromARGB(255, 124, 153, 172),
    //   width: 20,
    //   height: 20,
    // ),
    // Container(
    //   color: const Color.fromARGB(255, 104, 103, 172),
    //   width: 20,
    //   height: 20,
    // ),
  ];
}

List<Color> getHexColors() {
  return const [
    Color.fromARGB(255, 255, 239, 239),
    Color.fromARGB(255, 255, 203, 203),
    Color.fromARGB(255, 255, 188, 209),
    Color.fromARGB(255, 231, 251, 190),
    Color.fromARGB(255, 215, 127, 161),
    Color.fromARGB(255, 214, 229, 250),
    Color.fromARGB(255, 211, 222, 220),
    Color.fromARGB(255, 206, 123, 176),
    Color.fromARGB(255, 186, 171, 218),
    Color.fromARGB(255, 185, 131, 255),
    Color.fromARGB(255, 162, 103, 172),
    Color.fromARGB(255, 146, 169, 189),
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

// List<Color> getHexColors() {
//   return const [
//     // Color.fromARGB(255, 255, 253, 222),
//     // Color.fromARGB(255, 255, 249, 249),
//     Color.fromARGB(255, 200, 175, 231),
//     Color.fromARGB(255, 253, 140, 65),
//     Color.fromARGB(255, 253, 196, 122),
//     Color.fromARGB(255, 255, 188, 209),
//     Color.fromARGB(255, 190, 252, 175),
//     Color.fromARGB(255, 255, 134, 180),
//     Color.fromARGB(255, 175, 207, 252),
//     Color.fromARGB(255, 169, 214, 206),
//     Color.fromARGB(255, 215, 175, 252),
//     Color.fromARGB(255, 175, 252, 239),
//     Color.fromARGB(255, 252, 175, 233),
//     Color.fromARGB(255, 252, 175, 175), //Text
//     Color.fromARGB(255, 174, 209, 233),
//     // Color.fromARGB(255, 124, 153, 172),
//     // Color.fromARGB(255, 104, 103, 172), // Default
//     //Color.fromARGB(48, 104, 103, 172), //sombra
//     //Color.fromARGB(151, 104, 103, 172), //text in sombre
//   ];
// }

int toHex(int index) {
  final colors = getHexColors();
  return colors[index].value;
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
