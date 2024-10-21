import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabItems {
  static List<TabItem> items = [
    const TabItem(
      icon: FontAwesomeIcons.house,
      title: 'Home',
    ),
    const TabItem(
      icon: FontAwesomeIcons.carrot,
      title: 'My Recipes',
    ),
    const TabItem(
      icon: FontAwesomeIcons.plus,
      title: "Add Recipe",
    ),
    const TabItem(
      icon: FontAwesomeIcons.heart,
      title: 'Favorite',
    ),
    const TabItem(
      icon: FontAwesomeIcons.gear,
      title: 'Settings',
    ),
  ];
}
