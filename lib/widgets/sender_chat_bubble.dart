import 'package:flutter/material.dart';

class SenderChatBubble extends StatelessWidget {
  const SenderChatBubble({super.key, required this.message, required this.username, required this.isSame});

  final String message;
  final String username;
  final bool isSame;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            isSame? SizedBox(height: 8,) : Text(username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: isSame? BorderRadius.all(Radius.circular(12)) : BorderRadiusDirectional.only(
                  topStart: Radius.circular(12),
                  bottomEnd: Radius.circular(12),
                  bottomStart: Radius.circular(12),
                ),
              ),
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(message,
                  style: TextStyle(height: 1.3, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 8,),
        isSame? SizedBox(width: 40,) : CircleAvatar(radius: 20, child: Icon(Icons.person)),
      ],
    );
  }
}