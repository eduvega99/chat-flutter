import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/models/user.dart';
import 'package:chat/screens/screens.dart';
import 'package:chat/services/services.dart';
import 'package:chat/theme/app_theme.dart';


class UsersScreen extends StatefulWidget {

  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  
  final usersService = UsersService();
  List<User>users = [];

  @override
  void initState() {
    loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final isOnline = socketService.serverStatus == ServerStatus.online;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        leading: Icon( 
          isOnline ? Icons.wifi : Icons.wifi_off, 
          color: isOnline ? AppTheme.secondaryColor :  Colors.red,
        ),
        actions: [
          IconButton(
            icon: const Icon( Icons.logout ),
            onPressed: () {
              socketService.disconnect();
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            }
          )
        ]
      ),

      body: RefreshIndicator(
        onRefresh: loadUsers,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: users.length, 
          separatorBuilder: ( _ , __ ) => const Divider( color: AppTheme.secondaryColor ), 
          itemBuilder: ( context, index) => _ContactListTile(user: users[index]),
        ),
      )
    );
  }

  Future loadUsers() async {
    users = await usersService.getUsers();
    setState(() { });
  }
}

class _ContactListTile extends StatelessWidget {
  
  final User user;
  
  const _ContactListTile({ required this.user, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);

    return ListTile(
      title: Text(user.name),
      leading: CircleAvatar(
        foregroundColor: Colors.white,
        backgroundColor: AppTheme.primaryColor,
        child: Text( user.name.substring(0, 2) ),
      ),
      trailing: Icon(
        Icons.circle, 
        color: user.isOnline ? AppTheme.primaryColor : Colors.red,
        size: 10,
      ),
      onTap: () {
        chatService.fromUser = user;
        Navigator.push(context, _animateRoute());
      }
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