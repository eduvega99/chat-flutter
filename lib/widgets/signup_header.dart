import 'package:chat/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: AppTheme.primaryColor,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            right: 30,
            top: 80,
            child: Icon( Icons.person_add, size: 180, color: Colors.white.withAlpha(45), ),
          ),
          const Positioned(
            top: 70, 
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Registro', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30)),
          SizedBox( height: 15 ),
          Text('Mensajería totalmente gratis', style: TextStyle(color: Colors.white, fontSize: 18), overflow: TextOverflow.visible,),
        ],
      ),
    );
  }
}