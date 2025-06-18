import 'package:chat_app/widgets/receiver_chat_bubble.dart';
import 'package:chat_app/widgets/sender_chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterChat"),
        actions: [
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: () async {
              await FirebaseAuth.instance.signOut(); //signOut event is being listened to at main
            }, 
            icon: Icon(Icons.exit_to_app)
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              reverse: true,
              itemCount: 2,
              itemBuilder: (ctx, index) {
                if (index == 0) {return SenderChatBubble();}
                else {return RecieverChatBubble();}
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                SizedBox(width: 12,),
                Expanded(child: TextField(decoration: InputDecoration(label: Text("Send a message")),)),   
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send),
                  color: Theme.of(context).primaryColor,
                )             
              ]
            ),
          )
        ],
      )
    );
  }
}