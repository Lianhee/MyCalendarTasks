import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/core/values/icons.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/home/view.dart';
import 'package:mycalendar/app/modules/projects/view.dart';
import 'package:mycalendar/app/modules/stadistics/view.dart';

import '../calendar/view.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({Key? key}) : super(key: key);
  final Controller ctrl = Get.find<Controller>();
  @override
  Widget build(BuildContext context) {
    final icons = getButtonNavIconsData();
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _barItem(index: 0, icon: icons[0]),
            _barItem(index: 1, icon: icons[1]),
            const SizedBox(
              width: 50.0,
            ),
            _barItem(index: 2, icon: icons[2]),
            _barItem(index: 3, icon: icons[3]),
          ],
        ),
      ),
    );
  }

  _barItem({required int index, required IconData icon}) {
    final _currentIndex = ctrl.pageIndex.value;
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: _currentIndex == index
            ? const Color.fromARGB(255, 204, 175, 252)
            : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: IconButton(
        //update the bottom app bar view each time an item is clicked
        onPressed: () async {
          if (_currentIndex != index) {
            switch (index) {
              case 0:
                Get.to(() => const HomePage());
                break;
              case 1:
                Get.to(() => const StadisticsPage());
                break;
              case 2:
                Get.to(() => ProjectsPage());
                break;
              case 3:
                Get.to(() => const CalendarPage());
                break;
            }
            ctrl.pageIndex.value = index;
          }
        },
        iconSize: 27.0,
        icon: Icon(
          icon,
          //darken the icon if it is selected or else give it a different color
          color: _currentIndex == index
              ? Colors.white
              : const Color.fromARGB(255, 204, 175, 252),
        ),
      ),
    );
  }
}
