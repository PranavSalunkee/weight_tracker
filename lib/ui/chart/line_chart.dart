import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../constants/paddings.dart';
import '../../constants/strings.dart';
import '../../screens/home/home_model.dart';

class LineChartView extends StatefulWidget {
  const LineChartView({super.key, required this.data});
  final List<UserWeight> data;
  @override
  State<LineChartView> createState() => _LineChartViewState();
}

class _LineChartViewState extends State<LineChartView>
    with ProjectPaddings, ProjectStrings {
  List<UserWeight> chartData = [];

  @override
  void initState() {
    super.initState();
    initVisibleData();
  }

  void initVisibleData() {
    for (var element in widget.data) {
        chartData.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          margin: EdgeInsets.zero + EdgeInsets.only(top: paddingLight),
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.zero)),
          child: widget.data.isEmpty
              ? Center(child: Text('No Graph To Show'))
              : SfCartesianChart(
                  borderWidth: 5,
                  zoomPanBehavior: (widget.data.length > 5)
                      ? ZoomPanBehavior(
                          maximumZoomLevel: 0.2,
                          enablePinching: true,
                          zoomMode: ZoomMode.x,
                          enablePanning: true,
                        )
                      : null,
                  primaryXAxis: DateTimeCategoryAxis(
                    title: AxisTitle(text: 'Time'),
                    majorGridLines: const MajorGridLines(width: 0),
                    labelPlacement: LabelPlacement.onTicks,
                    isInversed: true,
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    dateFormat: DateFormat('dd/MM/yy'),
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(text: 'Weight'),
                    isVisible: true,
                    maximum: _calculateMaxValue,
                    minimum: _calculateMinValue,
                    desiredIntervals: _calculateListCost,
                    numberFormat: NumberFormat('0'),
                  ),
                  tooltipBehavior: TooltipBehavior(
                      enable: true, duration: 1300, animationDuration: 200),
                  series: <CartesianSeries<dynamic, dynamic>>[
                    StackedLineSeries<UserWeight, DateTime>(
                      animationDuration: 750,
                      markerSettings: const MarkerSettings(isVisible: true),
                      dataSource: chartData,
                      name: '',
                      xValueMapper: (UserWeight data, _) => data.date,
                      yValueMapper: (UserWeight data, _) => data.weight,
                    )
                  ],
                ),
        ),
      ],
    );
  }

  double get _calculateMaxValue {
    List<double> temp = chartData.map((e) => e.weight).toList();
    return chartData.length == 1 ? temp.reduce(max) + 20 : temp.reduce(max);
  }

  double get _calculateMinValue {
    List<double> temp = chartData.map((e) => e.weight).toList();
    return chartData.length == 1 ? temp.reduce(min) - 10 : temp.reduce(min);
  }

  int get _calculateListCost {
    Set<double> tempData = chartData.map((e) => e.weight).toList().toSet();
    return tempData.length % 2 == 0 ? tempData.length : tempData.length - 1;
  }
}
