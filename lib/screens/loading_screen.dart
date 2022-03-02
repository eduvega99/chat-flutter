import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/services/services.dart';


class LoadingScreen extends StatelessWidget {

  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
            child: Text('Espere...')
          );
        }, 
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final isAuthenticated = await authService.isLoggedIn();

    if ( isAuthenticated ) {
      socketService.connect();
      Navigator.pushReplacementNamed(context,  'users');
    } else {
      Navigator.pushReplacementNamed(context,  'login');
    }
  }
}