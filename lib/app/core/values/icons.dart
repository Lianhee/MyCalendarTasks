import 'package:flutter/material.dart';

List<Icon> getIcons() {
  final icons = getIconsData();
  const color = Color.fromARGB(255, 104, 103, 172);
  return [
    for (int i = 0; i < icons.length; i++)
      Icon(
        icons[i],
        color: color,
      ),
  ];
}

List<IconData> getIconsData() {
  return const [
    Icons.home,
    Icons.person,
    Icons.menu_book_rounded,
    Icons.work,
    Icons.restaurant_menu_rounded,
    Icons.sports_tennis_rounded,
    Icons.shopping_cart_outlined,
    Icons.celebration,
    Icons.emoji_transportation,
    Icons.phone_iphone,
    Icons.account_balance_wallet,
    Icons.emoji_food_beverage_rounded,
  ];
}

List<IconData> getPriorityIconsData() {
  return [
    Icons.looks_one,
    Icons.looks_two,
    Icons.looks_3,
    Icons.looks_4,
  ];
}

List<IconData> getRepeatIconsData() {
  return const [
    Icons.view_week_rounded,
    Icons.cases_rounded,
    Icons.repeat_one,
    Icons.today,
    Icons.event_outlined,
    Icons.edit_calendar_outlined,
  ];
}

List<IconData> getButtonNavIconsData() {
  return [
    Icons.home,
    Icons.bar_chart_outlined,
    Icons.bubble_chart_rounded,
    Icons.calendar_month,
  ];
}
