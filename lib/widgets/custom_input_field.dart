import 'package:flutter/material.dart';

import 'package:chat/theme/app_theme.dart';


class CustomInputField extends StatelessWidget {

  final String label;
  final TextInputType inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  
  const CustomInputField({
    required this.label, 
    required this.inputType,
    this.inputAction,
    this.controller,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _getLabelTextStyle()),

        const SizedBox(height: 10),

        TextFormField(
          obscureText: inputType == TextInputType.visiblePassword,
          keyboardType: inputType,
          textInputAction: inputAction,
          controller: controller,
        )
      ],
    );
  }

  TextStyle _getLabelTextStyle() {
    return const TextStyle(
      color: AppTheme.primaryColor,
      fontSize: 16, 
      fontWeight: FontWeight.bold
    );
  }
}