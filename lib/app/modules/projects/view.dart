import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/home/widgets/settings/drawer.dart';
import 'package:mycalendar/app/modules/home/widgets/settings/open_drawer.dart';
import 'package:mycalendar/app/modules/methods/bottom_navigator.dart';
import 'package:mycalendar/app/modules/methods/floating_action.dart';
import 'package:mycalendar/app/modules/projects/default_card.dart';
import 'package:mycalendar/app/modules/projects/new_project.dart';
import 'package:mycalendar/app/modules/projects/project_card.dart';

class ProjectsPage extends StatelessWidget {
  ProjectsPage({Key? key}) : super(key: key);

  final Controller ctrl = Get.find<Controller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuPage(),
      backgroundColor: const Color.fromARGB(255, 255, 249, 249),
      resizeToAvoidBottomInset: true,
      // drawer: const MenuPage(),
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 5,
                bottom: 0,
                //right: 15,
              ),
              child: OpenDrawer(
                title: 'Projects',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 0,
                //bottom: 5,
                left: 15,
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerRight,
                      onPressed: () async {
                        ctrl.updateProjectView();
                      },
                      icon: Obx((() {
                        bool zoom = ctrl.projectViewZoom.value;
                        return Icon(
                          (zoom) ? Icons.zoom_out : Icons.zoom_in,
                          color: const Color.fromARGB(255, 145, 120, 180),
                        );
                      }))),
                  IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerRight,
                    onPressed: () async {
                      newProject();
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 145, 120, 180),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 5,
                left: 10,
                right: 15,
              ),
              child: SizedBox(child: Obx(() {
                bool zoom = ctrl.projectViewZoom.value;
                return GridView.count(
                  crossAxisCount: (zoom) ? 2 : 3,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    ...ctrl.projects
                        .map((element) => LongPressDraggable(
                              data: element,
                              onDragStarted: () => ctrl.changeDeleting(true),
                              onDraggableCanceled: (_, __) =>
                                  ctrl.changeDeleting(false),
                              onDragEnd: (_) => ctrl.changeDeleting(false),
                              feedback: Opacity(
                                opacity: 0.8,
                                child: ProjectCard(
                                  project: element,
                                  sets: (zoom) ? 2 : 3,
                                ),
                              ),
                              child: ProjectCard(
                                project: element,
                                sets: (zoom) ? 2 : 3,
                              ),
                            ))
                        .toList(),
                    const DefaultWindow(),
                  ],
                );
              })),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingAction(),
    );
  }
}
