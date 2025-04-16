import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/medical_chatbot/views/widgets/chatbot_app_bar.dart';
import 'dart:math';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => ChatbotState();
}

class ChatbotState extends State<Chatbot> {
  final Dio _dio = Dio(
    BaseOptions(
      validateStatus: (status) => true,
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
    ),
  );

  final String _webhookUrl =
      'https://fianetcele.app.n8n.cloud/webhook/cf3cfd9f-6c81-4a30-b736-39d58f3245d6/chat';
  final String _sessionId =
      '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(10000)}';
  final ChatUser _currentUser = ChatUser(
    id: '1',
    firstName: 'Người',
    lastName: 'dùng',
  );
  final ChatUser _gptChatUser = ChatUser(
    id: '2',
    firstName: 'Bác sĩ',
    lastName: 'Chuột Lang Nước',
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
        typingUsers: _typingUsers,
        inputOptions: InputOptions(
          inputDecoration: InputDecoration(
            hintText: 'Nhập câu hỏi của bạn...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]
                : Colors.grey[200],
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          inputToolbarPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          inputToolbarMargin: const EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
          ),
        ),
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    try {
      setState(() {
        _messages.insert(0, m);
        _typingUsers.add(_gptChatUser);
      });

      final response = await _dio.post(
        _webhookUrl,
        data: {
          'chatInput': m.text,
          'sessionId': _sessionId,
          'metadata': {},
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;
        String content = '';

        if (responseData is Map) {
          if (responseData.containsKey('output')) {
            final outputData = responseData['output'];
            if (outputData is Map && outputData.containsKey('text')) {
              content = outputData['text'];
            } else if (outputData is String) {
              content = outputData;
            }
          } else {
            content = responseData['content'] ??
                responseData['text'] ??
                responseData['response'] ??
                responseData['message'] ??
                '';
          }
        } else if (responseData is String) {
          content = responseData;
        }

        if (content.isEmpty) {
          content =
              'Không thể xử lý phản hồi từ máy chủ. Vui lòng thử lại sau.';
        }

        setState(() {
          _messages.insert(
            0,
            ChatMessage(
              user: _gptChatUser,
              createdAt: DateTime.now(),
              text: content,
            ),
          );
          _typingUsers.remove(_gptChatUser);
        });
      } else {
        setState(() {
          _typingUsers.remove(_gptChatUser);
        });

        throw Exception(
          'Đã xảy ra lỗi từ server: ${response.statusCode}',
        );
      }
    } catch (e) {
      setState(() {
        _typingUsers.remove(_gptChatUser);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showMaterialBanner(
          const MaterialBanner(
            forceActionsBelow: true,
            content: AwesomeSnackbarContent(
              title: 'Chat với AI',
              message:
                  'Đã có lỗi xảy ra trong quá trình kết nối đến máy chủ. Vui lòng thử lại sau.',
              contentType: ContentType.failure,
              inMaterialBanner: true,
            ),
            actions: [
              SizedBox.shrink(),
            ],
          ),
        );

        Future.delayed(const Duration(milliseconds: 2000), () {
          if (mounted) {
            ScaffoldMessenger.of(context).clearMaterialBanners();
          }
        });
      }
    }
  }
}
