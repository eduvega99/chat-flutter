import 'package:flutter/material.dart';

import 'package:chat/theme/app_theme.dart';


class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.45,
      width: double.infinity,
      color: AppTheme.primaryColor,
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: -20,
            child: Icon(Icons.forum, color: Colors.white.withAlpha(40), size: 350)
          ),

          const Positioned(
            top: 80,
            left: 30,
            child: _HeaderContent()
          )
          
        ],
      ),
    );
  }
}

class _HeaderContent extends StatelessWidget {
  const _HeaderContent({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Icon(Icons.forum, color: Colors.white, size: 50),
        SizedBox( height: 15 ),
        Text('Bienvenido', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30)),
        SizedBox( height: 15 ),
        Text('ChatApp te conecta a lo que te importa', style: TextStyle(color: Colors.white, fontSize: 18)),
      ],
    );
  }
}