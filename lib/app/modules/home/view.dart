import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/home/widgets/eisenhower/eisenhower_view.dart';
import 'package:mycalendar/app/modules/home/widgets/settings/drawer.dart';
import 'package:mycalendar/app/modules/methods/bottom_navigator.dart';
import 'package:mycalendar/app/modules/methods/floating_action.dart';
import 'widgets/stadistics/overview.dart';
import 'widgets/settings/open_drawer.dart';

class HomePage extends GetView<Controller> {
  const HomePage({Key? key}) : super(key: key);

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
              child: OpenDrawer(),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 0,
                bottom: 2,
                left: 10,
                right: 10,
              ),
              child: OverviewWindow(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 5,
                left: 15,
                right: 10,
              ),
              child: Row(
                children: const [
                  Text(
                    'Today Tasks',
                    style: TextStyle(
                      color: Color.fromARGB(255, 145, 120, 180),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const EisenhowerView(),
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
