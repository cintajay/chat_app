import 'package:flutter/material.dart';

class RecieverChatBubble extends StatelessWidget {
  const RecieverChatBubble({super.key, required this.message, required this.username, required this.isSame});

  final String message;
  final String username;
  final bool isSame;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isSame ? SizedBox(width: 40,) : CircleAvatar(radius: 20, child: Icon(Icons.person)),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isSame ? SizedBox(height: 8,) : Text(username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: isSame ? BorderRadius.all(Radius.circular(12)) : BorderRadiusDirectional.only(
                  topEnd: Radius.circular(12),
                  bottomEnd: Radius.circular(12),
                  bottomStart: Radius.circular(12),
                ),
              ),
              color: Theme.of(context).colorScheme.secondary.withAlpha(200),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(message,
                  style: TextStyle(height: 1.3, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}