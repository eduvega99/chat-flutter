import 'package:chat/screens/screens.dart';
import 'package:flutter/material.dart';

import 'package:chat/models/user.dart';
import 'package:chat/theme/app_theme.dart';


class UsersScreen extends StatelessWidget {

  final users = [
    User(isOnline: true, email: 'aaa', nombre: 'Claudia', uid: 'aaa'),
    User(isOnline: false, email: 'aaa', nombre: 'Aa Papá', uid: 'aaa'),
    User(isOnline: true, email: 'aaa', nombre: 'Mamá', uid: 'aaa'),
    User(isOnline: true, email: 'aaa', nombre: 'Carla', uid: 'aaa'),
    User(isOnline: false, email: 'aaa', nombre: 'Aitor', uid: 'aaa'),
    User(isOnline: true, email: 'aaa', nombre: 'Rita', uid: 'aaa'),
    User(isOnline: false, email: 'aaa', nombre: 'Rafa', uid: 'aaa'),
    
  ];

  UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        leading: const Icon(
          Icons.wifi, color: AppTheme.secondaryColor,
          // Icons.wifi_off, color: Colors.red,
        ),
        actions: [
          IconButton(
            icon: const Icon( Icons.logout ),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login')
          )
        ]
      ),

      body: RefreshIndicator(
        onRefresh: () { 
          return Future( () => { } );
        },
        child: ListView.separated(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: users.length, 
          separatorBuilder: ( _ , __ ) => const Divider( color: AppTheme.secondaryColor ), 
          itemBuilder: ( context, index) => _ContactListTile(user: users[index]),
        ),
      )
    );
  }
}

class _ContactListTile extends StatelessWidget {
  
  final User user;
  
  const _ContactListTile({ required this.user, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.nombre),
      leading: CircleAvatar(
        foregroundColor: Colors.white,
        backgroundColor: AppTheme.primaryColor,
        child: Text( user.nombre.substring(0, 2) ),
      ),
      trailing: Icon(
        Icons.circle, 
        color: user.isOnline ? AppTheme.primaryColor : Colors.red,
        size: 10,
      ),
      onTap: () => Navigator.push(context, _animateRoute())
    );
  }

  PageRouteBuilder<dynamic> _animateRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => ChatScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
        return SlideTransition(
          child: child,  
          position: Tween( begin: const Offset(1, 0), end: Offset.zero ).animate(curvedAnimation),
        );
      },
    );
  }
}