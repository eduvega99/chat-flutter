import 'package:chat/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  final String text;
  final String uid;

  const ChatMessage({
    Key? key, 
    required this.text,
    required this.uid
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: uid == '123'
        ? Align(alignment: Alignment.centerRight, child: _Message(text: text, color: AppTheme.secondaryColor))
        : Align(alignment: Alignment.centerLeft, child: _Message(text: text, color: AppTheme.primaryColor))
    );
  }
}

class _Message extends StatelessWidget {

  final String text;
  final Color color;

  const _Message({
    Key? key, 
    required this.text, 
    required this.color
  } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric( vertical: 3 ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Text(text, style: const TextStyle(color: Colors.white)),
      decoration: _getBoxDecoration(),
    );
  }

  BoxDecoration _getBoxDecoration() {
    return BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.all( Radius.circular( 10 ) )
    );
  }
}