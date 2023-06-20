import 'package:flutter/material.dart';
import '../Models/messageModel.dart';

class ChatBubble extends StatelessWidget {
  final Message massage;
  const ChatBubble({required this.massage});

  @override
  Widget build(BuildContext context) {
    // Message massage;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 73, 179, 105),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(
          massage.message,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

class ChatBubbleFriend extends StatelessWidget {
  final Message massage;
  const ChatBubbleFriend({required this.massage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 70, 70, 75),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(
          massage.message,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
