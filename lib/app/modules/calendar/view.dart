import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/models/task.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/home/widgets/settings/drawer.dart';
import 'package:mycalendar/app/modules/home/widgets/settings/open_drawer.dart';
import 'package:mycalendar/app/modules/methods/bottom_navigator.dart';
import 'package:mycalendar/app/modules/methods/days.dart';
import 'package:mycalendar/app/modules/methods/floating_action.dart';
import 'package:mycalendar/app/modules/tasks/task_card.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    Key? key,
  }) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Controller ctrl = Get.find<Controller>();
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  CalendarFormat calendarView = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    ctrl.changeProject(ctrl.defaultProject.value);
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
              Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                  //bottom: 5,
                  left: 15,
                  right: 10,
                ),
                child: Row(
                  children: const [
                    Text(
                      'Calendar',
                      style: TextStyle(
                        color: Color.fromARGB(255, 145, 120, 180),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              TableCalendar(
                focusedDay: selectedDay,
                firstDay: DateTime.utc(2020, 12, 31),
                lastDay: DateTime.utc(2040, 12, 31),
                selectedDayPredicate: (day) {
                  return Days.diffDays(now: selectedDay, date: day) == 0;
                },
                onDaySelected: (selectDay, focusDay) {
                  setState(() {
                    selectedDay = selectDay;
                    focusedDay = focusDay; // update `_focusedDay` here as well
                  });
                },
                calendarFormat: calendarView,
                onFormatChanged: (format) {
                  setState(() {
                    calendarView = format;
                  });
                },
                onPageChanged: (focusedDay) {
                  focusedDay = focusedDay;
                },
              ),
              Obx(() {
                List<Task> tasks = ctrl.getDayTasks(selectedDay, ctrl.allTasks);
                return listingTasks(tasks);
              })
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigation(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingAction());
  }

  Widget listingTasks(List<Task> tasks) {
    return Column(
      children: [
        for (var task in tasks)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TaskCard(task: task, homePage: true, padding: 30),
          )
      ],
    );
  }
}
