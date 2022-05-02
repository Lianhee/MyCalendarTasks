import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/core/values/colors.dart';
import 'package:mycalendar/app/core/values/text.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/home/widgets/settings/drawer.dart';
import 'package:mycalendar/app/modules/home/widgets/settings/open_drawer.dart';
import 'package:mycalendar/app/modules/methods/bottom_navigator.dart';
import 'package:mycalendar/app/modules/methods/floating_action.dart';
import 'package:mycalendar/app/modules/stadistics/all_stadistics.dart';
import 'package:mycalendar/app/modules/stadistics/priority_stadistics.dart';

class StadisticsPage extends StatefulWidget {
  const StadisticsPage({Key? key}) : super(key: key);

  @override
  _StadisticsPageState createState() => _StadisticsPageState();
}

class _StadisticsPageState extends State<StadisticsPage> {
  Controller ctrl = Get.find<Controller>();
  final DateTime now = DateTime.now();

  bool priorityStadisticsView = true;
  bool allStadisticsView = true;

  @override
  Widget build(BuildContext context) {
    int done = 0;
    bool empty = true;
    List<List<int>> sizes = [];
    for (int i = 0; i < 4; i++) {
      List<int> size = ctrl.getPriorityStep(i, null);
      sizes.add(size);
      done += size[0];
      if (done > 0) {
        empty = false;
      }
    }
    ctrl.changeProject(ctrl.defaultProject.value);
    return Scaffold(
      drawer: const MenuPage(),
      backgroundColor: const Color.fromARGB(255, 255, 249, 249),
      resizeToAvoidBottomInset: true,
      // drawer: const MenuPage(),
      body: SafeArea(
        child: ListView(children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 5,
              bottom: 0,
              //right: 15,
            ),
            child: OpenDrawer(
              title: 'Stadistics',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: InkWell(
              onTap: () async {
                setState(() {
                  priorityStadisticsView = !priorityStadisticsView;
                });
              },
              child: Row(children: [
                Text(
                  'Priority Tasks Stadistics',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900,
                  ),
                ),
                const Spacer(),
                const SizedBox(
                  width: 15,
                  child: Icon(Icons.arrow_drop_down_rounded),
                ),
              ]),
            ),
          ),
          (priorityStadisticsView)
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Container(
                      height: Get.height / 3.5,
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
                      child: Center(
                          child: getPriorityProgress(
                        sizes: sizes,
                        isEmpty: empty,
                        colors: getPriorityColors(),
                        titles: getPriorityTitle(),
                      ))))
              : const Padding(padding: EdgeInsets.zero),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: InkWell(
              onTap: () async {
                setState(() {
                  allStadisticsView = !allStadisticsView;
                });
              },
              child: Row(children: [
                Text(
                  'All Tasks Stadistics',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900,
                  ),
                ),
                const Spacer(),
                const SizedBox(
                  width: 15,
                  child: Icon(Icons.arrow_drop_down_rounded),
                ),
              ]),
            ),
          ),
          (allStadisticsView)
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Container(
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
                      child: Center(
                        child: getAllProgress(
                            sizes: ctrl.getProjectsDoneTasks(),
                            // isEmpty: ,
                            // colors: colors,
                            titles: ctrl.getProjectsTitle()),
                      )))
              : const Padding(padding: EdgeInsets.zero)
        ]),
      ),
      bottomNavigationBar: BottomNavigation(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingAction(),
    );
  }
}
