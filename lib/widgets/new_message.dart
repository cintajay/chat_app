import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _textFieldController = TextEditingController();

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  void _submit() {
    final enteredMessage = _textFieldController.text;
    if (enteredMessage.trim().isEmpty) {
      return;
    }

    _textFieldController.clear();
    FocusScope.of(context).unfocus();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(label: Text("Send a message")),
            ),
          ),
          IconButton(
            onPressed: _submit,
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}