import 'dart:collection';

import 'package:flutter/material.dart';

import '../../constants/icons.dart';
import '../../constants/paddings.dart';
import '../../constants/radius.dart';
import '../../constants/strings.dart';
import '../../screens/home/home_model.dart';
import '../listTile/weightList_tile.dart';
import '../text/title_text.dart';
import '../textField/text_field.dart';

class WeightListView extends StatefulWidget with ProjectStrings, ProjectPaddings, ProjectRadius {
  WeightListView({
    required this.data,
    required this.update,
    required this.isLoading,
  });
  final List<UserWeight> data;
  final ValueChanged update;
  final bool isLoading;
  @override
  State<WeightListView> createState() => WeightListViewState();
}

class WeightListViewState extends State<WeightListView>
    with ProjectStrings, ProjectPaddings, ProjectIcons, TickerProviderStateMixin {
  late TextEditingController weightFormFieldController;
  bool isOkBtnActive = true;

  @override
  void initState() {
    super.initState();
    weightFormFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero + EdgeInsets.only(top: paddingLight),
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
      child: widget.isLoading
          ? const Center(child: CircularProgressIndicator())
          : widget.data.isEmpty
          ? Center(child: Text(''))
          : ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: (BuildContext context, int index) {
          UserWeight currentData = widget.data[index];
          return WeightListTile(
            date: currentData.date,
            weight: currentData.weight,
            onTap: () => doEdit(widget.data[index]),
          );
        },
      ),
    );
  }

  Future<void> doEdit(UserWeight userWeight) async {
      // EDIT DIALOG
      String stringWeight = userWeight.weight.toString();
      weightFormFieldController.text = stringWeight;
      await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Edit'),
                content: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: CustomFormField(
                        controller: weightFormFieldController,
                        onChanged: (text) {
                          isOkBtnActive = weightFormFieldController.text.isNotEmpty;
                          setState(() {});
                        },
                        hintText: stringWeight,
                        autoFocus: true,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('CANCEL',style: TextStyle(color: Colors.black),),
                  ),
                  TextButton(
                    onPressed: isOkBtnActive
                        ? () {
                      var weight = weightFormFieldController.text;
                      userWeight.weight = double.parse(weight);
                      widget.update(true);
                      Navigator.of(context).pop();
                    }
                        : null,
                    child: Text('OK',style: TextStyle(color: Colors.black),),
                  ),
                ],
              );
            },
          );
        },
      );

  }

}
