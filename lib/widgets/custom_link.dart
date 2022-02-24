import 'package:flutter/material.dart';

import 'package:chat/theme/app_theme.dart';


class CustomLink extends StatelessWidget {

  final String text;
  final String route;

  const CustomLink({
    Key? key, 
    required this.text, 
    required this.route
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(text, style: _getLinkStyle()),
      onTap: () => Navigator.pushReplacementNamed(context, route),
    );
  }

  TextStyle _getLinkStyle() {
    return const TextStyle(
      fontSize: 16,
      color: AppTheme.primaryColor,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline
    );
  }

}