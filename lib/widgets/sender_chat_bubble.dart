import 'package:flutter/material.dart';

class SenderChatBubble extends StatelessWidget {
  const SenderChatBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Name",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(12), bottomEnd: Radius.circular(12), bottomStart: Radius.circular(12))),
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text("Message",
                  style: TextStyle(height: 1.3, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 8,),
        CircleAvatar(radius: 20, child: Icon(Icons.person)),
      ],
    );
  }
}