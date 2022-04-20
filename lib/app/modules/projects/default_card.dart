import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/modules/projects/new_project.dart';

class DefaultWindow extends StatelessWidget {
  const DefaultWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    return InkWell(
      onTap: () async {
        newProject();
      },
      child: Container(
        width: width / 3,
        margin: const EdgeInsets.all(3.0),
        decoration: const BoxDecoration(
          color: Color.fromARGB(48, 104, 103, 172),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            color: Color.fromARGB(151, 104, 103, 172),
          ),
        ),
      ),
    );
  }
}
