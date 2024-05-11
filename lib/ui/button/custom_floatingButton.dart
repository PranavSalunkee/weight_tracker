import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';


class FloatingButtonAdd extends StatelessWidget with ProjectStrings, ProjectColors {
  FloatingButtonAdd({super.key, this.languageIndex, this.onPressed});
  final int? languageIndex;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        tooltip:  'ADD DATA',
        backgroundColor: Colors.blue,
        onPressed: onPressed,
        child: Icon(Icons.add_outlined, color: whiteWithOpacity));
  }
}
