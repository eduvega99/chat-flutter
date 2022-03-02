import 'package:animate_do/animate_do.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final authService = Provider.of<AuthService>(context);

    return FadeIn(
      child: SlideInUp(
        from: 4,
        child: Container(
          child: uid == authService.user!.uid
            ? Align(alignment: Alignment.centerRight, child: _Message(text: text, color: AppTheme.secondaryColor))
            : Align(alignment: Alignment.centerLeft, child: _Message(text: text, color: AppTheme.primaryColor))
        ),
      ),
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