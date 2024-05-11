import 'package:flutter/material.dart';
import 'package:weight_tracker/constants/colors.dart';


mixin ProjectIcons {
  final Icon icAdd = Icon(Icons.add_outlined, color: Colors.white.withOpacity(0.9));
  final Icon icDelete = Icon(Icons.delete_outlined, color: Colors.white.withOpacity(0.9));
  final Icon icWeight = const Icon(Icons.monitor_weight_outlined);

  // Tabbar
  final Icon icList = const Icon(Icons.list,color: Colors.blue,);
  final Icon icChart = const Icon(Icons.show_chart,color: Colors.blue);

  // ListView
  final Icon icCheck = Icon(Icons.check_circle_outlined, size: 30, color: Colors.red);
  final Icon icUncheck = Icon(Icons.radio_button_unchecked_outlined, size: 30, color: Colors.red);
  final Icon icCancel = const Icon(Icons.close_outlined);
  final Icon icSelectAll = const Icon(Icons.select_all_outlined);
}
