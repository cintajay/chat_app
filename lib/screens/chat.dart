import 'package:chat_app/widgets/new_message.dart';
import 'package:chat_app/widgets/receiver_chat_bubble.dart';
import 'package:chat_app/widgets/sender_chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  void _setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.subscribeToTopic("chat");
  }

  @override
  void initState() {
    super.initState();
    _setupPushNotifications();
  }

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
            child: StreamBuilder(stream: FirebaseFirestore.instance
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
                return ListView.builder(
                  padding: EdgeInsets.all(12),
                  reverse: true,
                  itemCount: loadedMessages.length,
                  itemBuilder: (ctx, index) {
                    final id = loadedMessages[index]['id'] as String;
                    final message = loadedMessages[index]['message'] as String;
                    final username = loadedMessages[index]['username'] as String;

                    final String? nextId = index+1 < loadedMessages.length ? loadedMessages[index+1]['id'] : null;
                    //index 0 is the latest message, index 0's UI depends on the prev id which is index 1
                    
                    if (id == FirebaseAuth.instance.currentUser!.uid) {
                      return SenderChatBubble(message: message, username: username, isSame: nextId == id ? true : false,);
                    } else {
                      return RecieverChatBubble(message: message, username: username, isSame: nextId == id ? true : false,);
                    }
                  },
                );
              },
            ),
          ),         
          NewMessage()
        ],
      )
    );
  }
}