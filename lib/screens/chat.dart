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
      body: const Placeholder()
    );
  }
}