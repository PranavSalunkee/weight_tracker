import 'package:flutter/material.dart';

import '../../constants/colors.dart';


class CustomTitleText extends StatefulWidget {
  const CustomTitleText({super.key, required this.text, this.textAlign});
  final String text;
  final TextAlign? textAlign;
  @override
  State<CustomTitleText> createState() => _CustomTitleTextState();
}

class _CustomTitleTextState extends State<CustomTitleText> with ProjectColors {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: primaryColor),
      textAlign: widget.textAlign,
    );
  }
}
