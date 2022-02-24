import 'package:flutter/material.dart';

import 'package:chat/widgets/widgets.dart';


class SignUpScreen extends StatelessWidget {

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [

          SignUpHeader(),
      
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
  
  const _SignUpForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Form(
        child: Column(
          children: [
    
            CustomInputField(
              label: 'Nombre', 
              inputType: TextInputType.name,
              inputAction: TextInputAction.next,
              onChanged: ( value ) { },
              validator: ( value ) { }
            ),
    
            const SizedBox( height: 30 ),
    
            CustomInputField(
              label: 'Correo', 
              inputType: TextInputType.emailAddress,
              inputAction: TextInputAction.next,
              onChanged: ( value ) { }, 
              validator: ( value ) { }
            ),
            
            const SizedBox( height: 30 ),
    
            CustomInputField(
              label: 'Contraseña', 
              inputType: TextInputType.visiblePassword,
              onChanged: ( value ) { }, 
              validator: ( value ) { }
            ),

            const SizedBox(height: 40),

            TextButton(
              child: const Text('Registrarse'),
              onPressed: () {},
            ),

            const SizedBox( height: 70 ),

            const CustomLink(text: '¿Ya tienes una cuenta?', route: 'login')
          ],
        )
      ),
    );
  }
}