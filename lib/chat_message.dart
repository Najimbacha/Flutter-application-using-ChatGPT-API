import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String sender;
  const ChatMessage({super.key, required this.sender, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 14),
          child: Text(
            sender,
          )
              .text
              .subtitle1(context)
              .make()
              .box
              .color(sender == "Me" ? Vx.gray800 : Vx.black)
              .p8
              .rounded
              .alignCenter
              .makeCentered(),
        ),
        Container(
          // decoration: BoxDecoration(),
          padding: const EdgeInsets.all(5),
          color: Colors.black26,
          child: Expanded(
            child: text.trim().text.bodyText1(context).make().px0(),
          ),
        )
      ],
    ).py8();
  }
}
