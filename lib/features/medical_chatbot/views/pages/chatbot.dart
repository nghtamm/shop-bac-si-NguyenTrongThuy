import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/medical_chatbot/views/widgets/chatbot_app_bar.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => ChatbotState();
}

class ChatbotState extends State<Chatbot> {
  final _openAI = OpenAI.instance.build(
    token: dotenv.env['OPENAI_API_KEY']!,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 20),
    ),
    enableLog: true,
  );

  final ChatUser _currentUser = ChatUser(
    id: '1',
    firstName: 'Người',
    lastName: 'Dùng',
  );
  final ChatUser _gptChatUser = ChatUser(
    id: '2',
    firstName: 'Chuột',
    lastName: 'Lang Nước',
    profileImage: AppAssets.capybara,
  );

  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatbotAppbar(),
      body: DashChat(
        currentUser: _currentUser,
        onSend: (ChatMessage m) {
          getChatResponse(m);
        },
        messages: _messages,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    try {
      setState(() {
        _messages.insert(0, m);
        _typingUsers.add(_gptChatUser);
      });

      List<Map<String, dynamic>> messagesHistory = _messages.reversed.map((m) {
        if (m.user == _currentUser) {
          return {'role': 'user', 'content': m.text};
        } else {
          return {'role': 'assistant', 'content': m.text};
        }
      }).toList();

      final request = ChatCompleteText(
        model: Gpt4ChatModel(),
        messages: messagesHistory,
        maxToken: 200,
      );

      final response = await _openAI.onChatCompletion(request: request);

      if (response != null) {
        for (var element in response.choices) {
          if (element.message != null) {
            setState(() {
              _messages.insert(
                0,
                ChatMessage(
                  user: _gptChatUser,
                  createdAt: DateTime.now(),
                  text: element.message!.content,
                ),
              );
            });
          }
        }
      }
      // setState(() {
      //   _typingUsers.remove(_gptChatUser);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showMaterialBanner(
          const MaterialBanner(
            forceActionsBelow: true,
            content: AwesomeSnackbarContent(
              title: 'Đã xảy ra lỗi',
              message: 'Vui lòng thử lại sau.',
              contentType: ContentType.failure,
              inMaterialBanner: true,
            ),
            actions: [
              SizedBox.shrink(),
            ],
          ),
        );

        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            ScaffoldMessenger.of(context).clearMaterialBanners();
          }
        });
      }
    }
  }
}
