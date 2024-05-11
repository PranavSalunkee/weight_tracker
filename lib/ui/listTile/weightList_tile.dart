import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';



import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../text/title_text.dart';

class WeightListTile extends StatefulWidget {
  const WeightListTile(
      {super.key,
      required this.date,
      required this.weight,
      this.onTap,});
  final DateTime date;
  final double weight;
  final void Function()? onTap;
  @override
  State<WeightListTile> createState() => _WeightListTileState();
}

class _WeightListTileState extends State<WeightListTile> with ProjectColors, ProjectIcons {

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child:
        ListTile(
            leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.monitor_weight_outlined)]),
            tileColor: Theme.of(context).colorScheme.background.withOpacity(0.6),
            title: CustomTitleText(text: '${widget.weight} kg'),
            subtitle: Text(
              DateFormat.yMMMMd().format(widget.date), style: TextStyle(fontSize: 15),
            )),
    );
  }
}
