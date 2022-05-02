import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OpenDrawer extends StatelessWidget {
  final String? title;
  const OpenDrawer({
    Key? key,
    this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String appBarTitle =
        title ?? DateFormat('EEEE, d').format(DateTime.now()).toString();

    return Row(
      children: [
        IconButton(
          onPressed: () async {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            Icons.menu_rounded,
            color: Color.fromARGB(255, 162, 103, 172),
          ),
        ),
        const Spacer(),
        Text(
          appBarTitle,
          style: const TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 162, 103, 172),
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () async {},
          icon: const Icon(
            Icons.notifications_outlined,
            color: Color.fromARGB(255, 162, 103, 172),
          ),
        ),
      ],
    );
  }
}
