import 'package:flutter/material.dart';

import '../../../constants/radius.dart';
import '../../../constants/strings.dart';
import '../../constants/paddings.dart';
import '../text/title_text.dart';

class WeightDataCard extends StatelessWidget
    with ProjectRadius, ProjectStrings, ProjectPaddings {
  WeightDataCard({super.key, this.currentData});

  final double? currentData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingHorizontalNormal,
      child: Card(
          color: Colors.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusLow)),
          child: Column(children: [
            Padding(
                padding: paddingVerticalNormal + paddingTopNormal,
                child: _DataRow(children: [
                  _CardWeightColumn('Current', currentData),
                ])),
          ])),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: children);
  }
}

class _CardWeightColumn extends StatelessWidget {
  const _CardWeightColumn(this.title, this.weightData);
  final String? title;
  final double? weightData;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
        Text(
          title ?? '-',
          style: TextStyle(color: Colors.white,fontSize: 25,),
          textAlign: TextAlign.center,
        ),
        Text(weightData == null ? '-' : '${weightData!.toStringAsFixed(1)}kg',
            style: TextStyle(color: Colors.white,fontSize: 30,), textAlign: TextAlign.center,)
      ]),
    );
  }
}
