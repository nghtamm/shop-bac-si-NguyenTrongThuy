import 'package:flutter/material.dart';

import 'package:shop_bacsi_nguyentrongthuy/features/xinchaochatgpt/views/widgets/ai_chat_appbar.dart';

import 'package:shop_bacsi_nguyentrongthuy/features/xinchaochatgpt/views/widgets/ai_chat_textbox.dart';

class AiChat extends StatelessWidget {
  const AiChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AiChatAppbar(),
      bottomNavigationBar: AiChatTextbox(
        textController: TextEditingController(),
        onSend: (String message) {},
      ),
      body: const Center(),
    );
  }
}
