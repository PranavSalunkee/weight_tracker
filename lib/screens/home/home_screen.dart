import 'package:flutter/material.dart';
import 'package:weight_tracker/screens/welcome/welcome_screen.dart';

import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../constants/radius.dart';
import '../../services/cache/shared_manager.dart';
import 'package:weight_tracker/screens/home/home_viewModel.dart';

import '../../ui/appBar/custom_appBar.dart';
import '../../ui/button/custom_floatingButton.dart';
import '../../ui/card/data_card.dart';
import '../../ui/chart/line_chart.dart';
import '../../ui/listView/weightList_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, this.manager, required this.userName});
  // SharedManager
  final SharedManager? manager;
  final String userName;
  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends HomeViewModel with ProjectColors, ProjectIcons, ProjectRadius {
  @override
  void initState() {
    super.initState();
    getValues();
  }
  @override
  Widget build(BuildContext context) {
    views = [
      WeightListView(
        key: listViewKey,
        data: dataList,
        update: (value) => updateCardData(),
        isLoading: isLoading,
      ),
      LineChartView(data: dataList),
    ];
    return  Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: ProjectAppBar(
            manager: widget.manager, onExitClick: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen() )); },
          ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: selectedIndex,
            elevation: 10,
            onTap: (value) {
              selectedIndex = value;
              value == 1 ? isFloatingActive = false : isFloatingActive = true;
              setState(() {
              });
            },
            items: [
              BottomNavigationBarItem(label: '0', icon: icList,backgroundColor: Colors.blue),
              BottomNavigationBarItem(label: '1', icon: icChart, backgroundColor: Colors.blue),
            ],
          ),
          floatingActionButton: isFloatingActive
              ? (FloatingButtonAdd(onPressed: () => showCustomBottomSheet(context))
              )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: Padding(
              padding: paddingTopNormal,
              child: Column(children: [
                WeightDataCard(
                  currentData: currentData

                ),
                Expanded(child: views.elementAt(selectedIndex)),
              ])));
  }
}