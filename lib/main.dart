import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/routes/app_routes.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/theme/app_theme.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {

  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatApp',
      theme: AppTheme.getTheme(),
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.appRoutes,
    );
  }
}