import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/modules/authentication/auth.dart';
import 'package:mycalendar/app/modules/authentication/profile.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/projects/projects_view.dart';
import 'package:mycalendar/app/modules/projects/view.dart';
import 'package:mycalendar/app/modules/tasks/all_tasks.dart';
import 'package:mycalendar/app/modules/welcome/welcome.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<Controller>();
    return Drawer(
      child: Column(
        children: <Widget>[
          _buildDrawerHeader(),
          _buildDrawerItem(
            icon: Icons.account_circle,
            text: 'My Profile',
            onTap: () => {Get.back(), Get.to(() => const ProfilePage())},
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.folder,
            text: 'Projects',
            onTap: () => {
              Get.back(),
              ctrl.pageIndex.value = 2,
              Get.to(() => ProjectsPage())
            },
          ),
          _listProjects(),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.list_rounded,
            text: 'All Tasks',
            onTap: () => {
              Get.back(),
              ctrl.pageIndex.value = 2,
              Get.to(() => const AllTasksList())
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildDrawerItem(
                          icon: Icons.exit_to_app_outlined,
                          text: "Logout",
                          onTap: () => {
                            Authentication.logout(),
                            Get.to(() => const WelcomePage()),
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _listProjects() {
    final ctrl = Get.find<Controller>();
    return Container(
        constraints: const BoxConstraints(
          minHeight: 0.0,
          maxHeight: 296,
        ),
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.only(
              left: 15,
            ),
            child: ListView(
              children: [
                ...ctrl.projects
                    .map((element) => SizedBox(
                          height: 50,
                          child: InkWell(
                            onTap: () {
                              ctrl.changeProject(element);
                              Get.back();
                              Get.to(() => const ProjectWindow());
                            },
                            child: Row(children: [
                              Icon(
                                element.icon,
                                color: element.color,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                element.title,
                              )
                            ]),
                          ),
                        ))
                    .toList(),
              ],
            ),
          );
        }));
  }
}

class MenuItem extends StatelessWidget {
  final String itemText;
  final String itemIcon;
  final int selected;
  final int position;
  const MenuItem(
      {Key? key,
      required this.itemText,
      required this.itemIcon,
      required this.selected,
      required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: selected == position
          ? const Color.fromARGB(250, 21, 30, 38)
          : const Color.fromARGB(250, 31, 43, 54),
      child: Row(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(20),
              child: Image.asset("assets/images/$itemIcon.png")),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              itemText,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildDrawerHeader() {
  return DrawerHeader(
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 186, 149, 230),
    ),
    child: Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CircleAvatar(
            radius: 45.0,
            backgroundColor: const Color.fromARGB(0, 197, 171, 226),
            child: ClipOval(
              child: Image.asset(
                "assets/images/cat2.png",
                fit: BoxFit.contain,
                height: 100,
              ),
            ),
          ),
        ),
        const Align(
          alignment: Alignment(1.0, 0.0),
          child: SizedBox(
            width: 150,
            child: Text(
              "My Calendar ",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDrawerItem(
    {required IconData icon,
    required String text,
    required GestureTapCallback onTap}) {
  return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Icon(icon),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(text),
            )
          ],
        ),
        onTap: onTap,
      ));
}
