import 'package:flutter/material.dart';

import 'package:chat/widgets/widgets.dart';


class LogInScreen extends StatelessWidget {

  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          
          LoginHeader(),

          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: _LoginForm()
            ),
          )
        ],
      )
    );
  }
}

class _LoginForm extends StatelessWidget {
  
  const _LoginForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Form(
        child: Column(
          children: [

            CustomInputField(
              label: 'Email', 
              inputType: TextInputType.emailAddress,
              inputAction: TextInputAction.next,
              onChanged: (value) { },// loginForm.email = value,
              validator: (value) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);
                return regExp.hasMatch(value ?? '') ? null : 'El formato de correo no es válido'; 
              },
            ),

            const SizedBox(height: 30),

            CustomInputField(
              label: 'Contraseña',
              inputType: TextInputType.visiblePassword, 
              onChanged: ( value ) { },
              validator: ( value ) {
                if (value!.isNotEmpty && value.length > 5) {
                  return 'La contraseña debe tener al menos 5 carácteres';
                }
              }
            ),

            const SizedBox(height: 40),

            TextButton(
              child: const Text('Login'),
              onPressed: () => Navigator.pushReplacementNamed(context,  'users'),
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