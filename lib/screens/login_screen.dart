import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/helpers/show_alerts.dart';
import 'package:chat/services/services.dart';
import 'package:chat/widgets/widgets.dart';


class LogInScreen extends StatelessWidget {

  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          const LoginHeader(),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: _LoginForm()
            ),
          )
        ],
      )
    );
  }
}

class _LoginForm extends StatelessWidget {
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  _LoginForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Form(
        child: Column(
          children: [

            CustomInputField(
              label: 'Email', 
              inputType: TextInputType.emailAddress,
              inputAction: TextInputAction.next,
              controller: _emailController,
            ),

            const SizedBox(height: 30),

            CustomInputField(
              label: 'Contraseña',
              inputType: TextInputType.visiblePassword,
              controller: _passwordController
            ),

            const SizedBox(height: 40),

            TextButton(
              child: const Text('Login'),
              onPressed: authService.isLoading
                ? null 
                : () async {
                  FocusScope.of(context).unfocus();
                  final isLogged = await authService.login(_emailController.text, _passwordController.text);
                  if ( isLogged ) {
                    socketService.connect();
                    Navigator.pushReplacementNamed(context,  'users');
                  } else {
                    showAlert(context, 'Error', 'Por favor, revise sus credenciales.');
                  }
                },
            ),

            const SizedBox(height: 70),

            Container(
              child: const CustomLink(text: 'Registrarse', route: 'sign_up'),
              padding: const EdgeInsets.only(bottom: 30),
            )

          ],
        ),
      ),
    );
  }
}