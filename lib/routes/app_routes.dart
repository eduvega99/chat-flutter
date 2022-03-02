import 'package:flutter/widgets.dart';

import 'package:chat/screens/screens.dart';


class AppRoutes {

  static String initialRoute = 'loading';
  
  static Map<String, Widget Function(BuildContext)> appRoutes = {
    'login':  ( _ ) => const LogInScreen(),
    'sign_up': ( _ ) => const SignUpScreen(),
    'users':   ( _ ) => const UsersScreen(),
    'chat':    ( _ ) => const ChatScreen(),
    'loading': ( _ ) => const LoadingScreen(),
  };

}