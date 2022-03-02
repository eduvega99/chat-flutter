import 'package:chat/helpers/show_alerts.dart';
import 'package:chat/services/services.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/widgets.dart';


class SignUpScreen extends StatelessWidget {

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          const SignUpHeader(),
      
          Expanded(
            child: SingleChildScrollView(
              child: _SignUpForm()
            )
          )
      
        ],
      )
    );
  }
}

class _SignUpForm extends StatelessWidget {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  _SignUpForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Form(
        child: Column(
          children: [
    
            CustomInputField(
              controller: _nameController,
              label: 'Nombre', 
              inputType: TextInputType.name,
              inputAction: TextInputAction.next,
            ),
    
            const SizedBox( height: 30 ),
    
            CustomInputField(
              controller: _emailController,
              label: 'Correo', 
              inputType: TextInputType.emailAddress,
              inputAction: TextInputAction.next,
            ),
            
            const SizedBox( height: 30 ),
    
            CustomInputField(
              controller: _passwordController,
              label: 'Contraseña', 
              inputType: TextInputType.visiblePassword,
            ),

            const SizedBox(height: 40),

            TextButton(
              child: const Text('Registrarse'),
              onPressed: authService.isLoading
                ? null 
                : () async {
                  FocusScope.of(context).unfocus();
                  final isRegistered = await authService.register(_nameController.text, _emailController.text, _passwordController.text);
                  if ( isRegistered ) {
                    final socketService = Provider.of<SocketService>(context, listen: false);
                    socketService.connect();
                    Navigator.pushReplacementNamed(context,  'users');
                  } else {
                    showAlert(context, 'Problema con el registro', 'Por favor, revise que todos los campos son correctos. Si el error persiste, pruebe con otro email.');
                  }
                },
            ),

            const SizedBox( height: 70 ),

            const CustomLink(text: '¿Ya tienes una cuenta?', route: 'login')
          ],
        )
      ),
    );
  }
}