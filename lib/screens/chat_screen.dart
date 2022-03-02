import 'package:flutter/material.dart';

import 'package:chat/services/services.dart';
import 'package:chat/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'package:chat/models/models.dart';


class ChatScreen extends StatefulWidget {


  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final List<ChatMessage> messages = [ ];
  final textController = TextEditingController();
  final scrollController = ScrollController();

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  @override
  void initState() {
    super.initState();

    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);
  
    socketService.socket.on('personal-message', _listenMessage);

    _loadMessages(chatService.fromUser.uid);
  }

  void _loadMessages(String uid) async {
    List<Message> chat = await chatService.getChat(uid);
    final history = chat.map( (message) {
      return ChatMessage(text: message.message, uid: message.from);
    });

    messages.addAll(history);
    setState(() { });
  }

  @override
  void dispose() {
    socketService.socket.off('personal-message');
    super.dispose();
  }

  void _listenMessage(dynamic data) {
    final message = ChatMessage(text: data['message'], uid: data['from']);
    messages.insert(0, message);
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    final fromUser = chatService.fromUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(fromUser.name),
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
              child: RefreshIndicator(
                onRefresh: () async {
                  chatService.page++;
                  _loadMessages(chatService.fromUser.uid);
                },
                child: _Chat(messages: messages, controller: scrollController)
              )
            ),

            InputMessage(
              textController: textController,
              onPressed: () {
                final message = textController.text;

                messages.insert(0, ChatMessage(text: message, uid: authService.user!.uid));
                textController.clear();
                scrollController.jumpTo(scrollController.position.maxScrollExtent);
                setState(() { });
                
                socketService.emit('personal-message', {
                  'from': authService.user!.uid,
                  'to'  : chatService.fromUser.uid,
                  'message': message
                });

              },
            )
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

  final List<ChatMessage> messages;
  final ScrollController controller;
  
  const _Chat({ 
    Key? key, 
    required this.messages, 
    required this.controller 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: messages.length,
      itemBuilder: ( _ , index) => messages.reversed.toList()[index],
    );
  }
}