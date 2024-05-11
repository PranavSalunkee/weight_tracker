import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {super.key,
      required this.controller,
      this.onChanged,
      this.textAlign,
      this.autoFocus,
      this.focusNode,
      this.textInputAction,
      this.isZeroIn,
      this.labelText,
      this.hintText});
  final void Function(String)? onChanged;
  final bool? autoFocus;
  final bool? isZeroIn;
  final TextAlign? textAlign;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: Colors.transparent));

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.blue, // Navigation bar color
      statusBarColor: Colors.blue, // Status bar color
      systemNavigationBarIconBrightness: Brightness.light, // Navigation bar icons' color
      statusBarIconBrightness: Brightness.light, // Status bar icons' color
    ));

    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(fontSize: 30,color: Colors.white),
      focusNode: focusNode,
      autofocus: autoFocus ?? false,
      textInputAction: textInputAction,
      textAlign: textAlign ?? TextAlign.center,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder,
        label: Center(child: Text(labelText ?? '')),
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: outlineInputBorder,
        filled: true,
        fillColor: Colors.blue,
      ),
    );
  }
}
