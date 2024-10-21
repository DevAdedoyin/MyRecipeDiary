import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:myrecipediary/dashboard/presentation/tabs/tab_item_list.dart';
import 'package:myrecipediary/dashboard/presentation/tabs/tab_widget_list.dart';
import 'package:myrecipediary/dashboard/repository/tab_state_repo.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final tabState_ = ref.watch(tabState);
    return Scaffold(
      body: TabWidgetList.tabWidgetList[tabState_],
      bottomNavigationBar: BottomBarInspiredInside(
        elevation: 5,
        items: TabItems.items,
        backgroundColor: Colors.white,
        color: AppColors.midGreyColor,
        colorSelected: Colors.white,
        indexSelected: tabState_,
        itemStyle: ItemStyle.circle,
        animated: true,
        chipStyle: const ChipStyle(
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            convexBridge: true,
            background: AppColors.secondaryColor,
        ),
        onTap: (int index) => setState(() {
          ref.read(tabState.notifier).state = index;
        }),


      ),
    );
  }
}
