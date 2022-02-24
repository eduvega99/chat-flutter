import 'package:flutter/material.dart';

import 'package:chat/theme/app_theme.dart';


class CustomInputField extends StatelessWidget {

  final String label;
  final TextInputType inputType;
  final Function(String?) onChanged;
  final String? Function(String?) validator;
  final TextInputAction? inputAction;
  
  const CustomInputField({
    required this.label, 
    required this.inputType, 
    required this.onChanged, 
    required this.validator,
    this.inputAction,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _getLabelTextStyle()),

        const SizedBox(height: 10),

        _InputField(inputType: inputType, onChange: onChanged, validator: validator, inputAction: inputAction)
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

class _InputField extends StatelessWidget {
  
  final TextInputType inputType;
  final Function(String? p1) onChange;
  final String? Function(String? p1) validator;
  final TextInputAction? inputAction;

  const _InputField({
    Key? key,
    required this.inputType,
    required this.onChange,
    required this.validator,
    this.inputAction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: inputType == TextInputType.visiblePassword,
      keyboardType: inputType,
      onChanged: onChange,
      validator: validator,
      textInputAction: inputAction,
    );
  }
}