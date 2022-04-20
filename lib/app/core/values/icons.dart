import 'package:flutter/material.dart';

List<Icon> getIcons() {
  //Default color
  const color = Color.fromARGB(255, 104, 103, 172);
  return const [
    Icon(
      Icons.home,
      color: color,
    ),
    Icon(
      Icons.person,
      color: color,
    ),
    Icon(
      Icons.menu_book_rounded,
      color: color,
    ),
    Icon(
      Icons.work,
      color: color,
    ),
    Icon(
      Icons.restaurant_menu_rounded,
      color: color,
    ),
    Icon(
      Icons.sports_tennis_rounded,
      color: color,
    ),
    Icon(
      Icons.shopping_cart_outlined,
      color: color,
    ),
    Icon(
      Icons.celebration,
      color: color,
    ),
    Icon(
      Icons.emoji_transportation,
      color: color,
    ),
    Icon(
      Icons.phone_iphone,
      color: color,
    ),
    Icon(
      Icons.account_balance_wallet,
      color: color,
    ),
    Icon(
      Icons.emoji_food_beverage_rounded,
      color: color,
    ),
  ];
}

List<IconData> getIconsData() {
  return const [
    Icons.star,
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
