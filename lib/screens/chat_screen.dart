import 'package:flutter/material.dart';

import 'package:chat/widgets/widgets.dart';


class ChatScreen extends StatelessWidget {

  final List<Map<String, String>> messages = [
    { 'uid': '123', 'text': 'Hola, qué tal?' },
    { 'uid': '321', 'text': 'Bien, y tú?' },
    { 'uid': '123', 'text': 'Pues bien. Qué tal las clases?' },
    { 'uid': '321', 'text': 'Pues ya terminé el examen' },
    { 'uid': '321', 'text': 'Pero bueno, a ver qué tal sale' },
    { 'uid': '123', 'text': 'Seguro que bien, no te rayes' },
    { 'uid': '123', 'text': 'Hola, qué tal?' },
    { 'uid': '321', 'text': 'Bien, y tú?' },
    { 'uid': '123', 'text': 'Pues bien. Qué tal las clases?' },
    { 'uid': '321', 'text': 'Pues ya terminé el examen' },
    { 'uid': '321', 'text': 'Pero bueno, a ver qué tal sale' },
    { 'uid': '123', 'text': 'Seguro que bien, no te rayes' },
    { 'uid': '123', 'text': 'Hola, qué tal?' },
    { 'uid': '321', 'text': 'Bien, y tú?' },
    { 'uid': '123', 'text': 'Pues bien. Qué tal las clases?' },
    { 'uid': '321', 'text': 'Pues ya terminé el examen' },
    { 'uid': '321', 'text': 'Pero bueno, a ver qué tal sale' },
    { 'uid': '123', 'text': 'Seguro que bien, no te rayes' },
    { 'uid': '123', 'text': 'Hola, qué tal?' },
    { 'uid': '321', 'text': 'Bien, y tú?' },
    { 'uid': '123', 'text': 'Pues bien. Qué tal las clases?' },
    { 'uid': '321', 'text': 'Pues ya terminé el examen' },
    { 'uid': '321', 'text': 'Pero bueno, a ver qué tal sale' },
    { 'uid': '123', 'text': 'Seguro que bien, no te rayes' },
  ];

  ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Claudia'),
        leading: IconButton(
          icon: const Icon( Icons.arrow_back ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      
      body: Container(
        padding: const EdgeInsets.symmetric( horizontal: 10 ),
        decoration: _getBackgroundChat(),
        child: Column(
          children: [
            Expanded(
              child: _Chat(messages: messages)
            ),

            InputMessage()
          ],
        ),
      )
    );
  }

  BoxDecoration _getBackgroundChat() {
    return BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.3), BlendMode.dstATop),
          image: const AssetImage('assets/chat_background.png')
        )
      );
  }
}

class _Chat extends StatelessWidget {

  final List<Map<String, String>> messages;
  
  const _Chat({ Key? key, required this.messages }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: messages.length,
      itemBuilder: ( _ , index) => ChatMessage(text: messages[index]['text']!, uid: messages[index]['uid']!),
    );
  }
}