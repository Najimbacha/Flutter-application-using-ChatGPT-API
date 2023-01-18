import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:tutor/animation/loading.dart';
import 'package:tutor/chat_message.dart';
import 'package:tutor/secret/api.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<ChatMessage> _message = [];
  bool _istyping = false;
  ChatGPT? chatGpt;
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    chatGpt = ChatGPT.instance.builder(apiKey);
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void _sendMessage() {
    ChatMessage msg = ChatMessage(sender: "Me", text: _controller.text);

    setState(() {
      _message.insert(0, msg);
      _istyping = true;
    });

    _controller.clear();

    final response = CompleteReq(
      prompt: msg.text,
      model: kTranslateModelV3,
      temperature: 1,
      frequency_penalty: 2,
      max_tokens: 200,
    );
    subscription = chatGpt!
        .builder(apiKey, orgId: "")
        .onCompleteText(request: response)
        .asStream()
        // .onCompleteStream(request: response)
        .listen((response) {
      // Vx.log(response);
      ChatMessage botMessage =
          ChatMessage(sender: "Ai", text: response!.choices[0].text);
      setState(() {
        _message.insert(0, botMessage);
        _istyping = false;
      });
    });
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: TextField(
              // onSubmitted: (value) => _sendMessage(),
              onSubmitted: (value) {
                if (_controller.text.isNotBlank) {
                  _sendMessage();
                }
              },
              controller: _controller,
              decoration:
                  const InputDecoration.collapsed(hintText: "Sent a Message"),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              if (_controller.text.isNotBlank) {
                _sendMessage();
              }
            },
            // onPressed: () => _sendMessage(),
            icon: const Icon(Icons.send_outlined))
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[160],
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                padding: Vx.m8,
                itemCount: _message.length,
                itemBuilder: (context, index) {
                  return _message[index];
                },
              ),
            ),
            if (_istyping) const ThreeDotLoadingIndicator(),
            Container(
              decoration: BoxDecoration(
                color: context.cardColor,
              ),
              child: _buildTextComposer(),
            )
          ],
        ),
      ),
    );
  }
}
