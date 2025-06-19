import 'package:chat_app/widgets/new_message.dart';
import 'package:chat_app/widgets/receiver_chat_bubble.dart';
import 'package:chat_app/widgets/sender_chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          StreamBuilder(stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy('timestamp', descending: true)
              .snapshots(), 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No messages found"),);
              }
              if (snapshot.hasError) {
                return Center(child: Text("Something went wrong..."),);
              }
              final loadedMessages = snapshot.data!.docs;
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(12),
                  reverse: true,
                  itemCount: loadedMessages.length,
                  itemBuilder: (ctx, index) {
                    final id = loadedMessages[index]['id'] as String;
                    final message = loadedMessages[index]['message'] as String;
                    final username = loadedMessages[index]['username'] as String;
                    
                    if (id == FirebaseAuth.instance.currentUser!.uid) {
                      return SenderChatBubble(message: message, username: username,);
                    } else {
                      return RecieverChatBubble(message: message, username: username,);
                    }
                  },
                ),
              );
            },
          ),         
          NewMessage()
        ],
      )
    );
  }
}