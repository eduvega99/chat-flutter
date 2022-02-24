import 'package:chat/routes/app_routes.dart';
import 'package:chat/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp( const MyApp() );

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