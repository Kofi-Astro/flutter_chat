import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enteredMessage = '';

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    String userId = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection('chat').add(
      {
        'text': _enteredMessage.trim(),
        'time-created': Timestamp.now(),
        'userId': userId,
      },
    );
    _controller.clear();
    setState(() {
      _enteredMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Send Message',
            ),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          )),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
