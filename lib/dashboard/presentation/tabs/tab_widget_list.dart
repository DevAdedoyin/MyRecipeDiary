

import 'package:flutter/cupertino.dart';
import 'package:myrecipediary/dashboard/presentation/tabs/favorite.dart';
import 'package:myrecipediary/dashboard/presentation/tabs/home/home.dart';
import 'package:myrecipediary/dashboard/presentation/tabs/my_recipe.dart';
import 'package:myrecipediary/dashboard/presentation/tabs/settings.dart';
import 'package:myrecipediary/main.dart';

import 'add_recipe.dart';

class TabWidgetList {

  static List<Widget> tabWidgetList = [
    const HomeTab(),
    const MyRecipeTab(),
    const AddRecipeTab(),
    const FavoriteTab(),
    const SettingsTab()
  ];
}