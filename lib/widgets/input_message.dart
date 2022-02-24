import 'package:chat/theme/app_theme.dart';
import 'package:flutter/material.dart';

class InputMessage extends StatelessWidget {

  final _textController = TextEditingController();

  InputMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      padding: const EdgeInsets.symmetric( horizontal: 5, vertical:  3 ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _MessageBox( textController: _textController ),

          const SizedBox( width: 10 ),

          _SendButton( textController: _textController )
        ],
      ),
    );
  }
}

class _MessageBox extends StatelessWidget {

  final TextEditingController textController;

  const _MessageBox({ 
    Key? key, 
    required this.textController 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: textController,
        autocorrect: true,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: _getHintDecoration()
      )
    );
  }

  InputDecoration _getHintDecoration() {
    return const InputDecoration(
      hintText: 'Escribe un mensaje',
      contentPadding: EdgeInsets.symmetric( vertical: 15, horizontal: 12 ),
      filled: true,
      fillColor: Colors.white,
    );
  }
}

class _SendButton extends StatelessWidget {

  final TextEditingController textController;
  
  const _SendButton({ 
    Key? key, 
    required this.textController 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: AppTheme.primaryColor,
          elevation: 1,
          child: const Icon( Icons.send, color: Colors.white ),
          onPressed: () {
            print(textController.text);
            textController.clear();
          }
        ),
      ),
    );
  }
}