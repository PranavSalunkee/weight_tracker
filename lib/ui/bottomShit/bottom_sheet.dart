import 'package:flutter/material.dart';
import '../../constants/paddings.dart';
import '../../constants/strings.dart';
import '../button/elevated_button.dart';
import '../text/title_text.dart';
import '../textField/text_field.dart';

class DataBottomSheetContent extends StatefulWidget {
  const DataBottomSheetContent({
    super.key,
    required this.setState,
    this.onChanged,
    required this.weightFormFieldController,
    required this.isOkBtnActive,
    this.onPressed,
    this.customDatePicker,
  });
  final StateSetter setState;
  final Function(String)? onChanged;
  final TextEditingController weightFormFieldController;
  final bool isOkBtnActive;
  final void Function()? onPressed;
  final Widget? customDatePicker;

  @override
  State<DataBottomSheetContent> createState() => _DataBottomSheetContentState();
}

class _DataBottomSheetContentState extends State<DataBottomSheetContent>
    with ProjectPaddings, ProjectStrings {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: paddingHorizontalVeryHigh +
                  EdgeInsets.only(bottom: paddingHigh),
              child: CustomTitleText(text: 'Add Record')),
          Padding(
            padding:
                paddingHorizontalVeryHigh + EdgeInsets.only(bottom: paddingMed),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      flex: 10,
                      child: CustomFormField(
                          controller: widget.weightFormFieldController,
                          onChanged: widget.onChanged,
                          autoFocus: true,
                          textInputAction: TextInputAction.done)),
                ]),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: paddingMed),
            child: SizedBox(height: 100, child: widget.customDatePicker),
          ),
          Padding(
            padding:
                paddingHorizontalVeryHigh + EdgeInsets.only(bottom: paddingMed),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      flex: 3,
                      child: CustomElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          text: 'CANCEL')),
                  const Spacer(),
                  Expanded(
                      flex: 3,
                      child: CustomElevatedButton(
                          onPressed: widget.onPressed, text: 'OK')),
                ]),
          )
        ]);
  }
}
