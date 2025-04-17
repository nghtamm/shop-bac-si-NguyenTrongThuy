import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/local/global_storage.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/medical_chatbot/views/widgets/chatbot_app_bar.dart';
import 'dart:math';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => ChatbotPageState();
}

class ChatbotPageState extends State<ChatbotPage> {
  // Settings for 'dio'
  final Dio _dio = Dio(
    BaseOptions(
      validateStatus: (status) => true,
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
    ),
  );

  // n8n webhook
  final String _webhookUrl =
      'https://fianetcele.app.n8n.cloud/webhook/cf3cfd9f-6c81-4a30-b736-39d58f3245d6/chat';

  // Create an unique ID for chat session
  final String _sessionId =
      '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(10000)}';

  // Create user objects
  final ChatUser _currentUser = ChatUser(
    id: '1',
    firstName: 'Người',
    lastName: 'dùng',
  );
  final ChatUser _gptChatUser = ChatUser(
    id: '2',
    firstName: 'Bác sĩ',
    lastName: 'Capybara',
    profileImage: AppAssets.capybara,
  );

  // Create different list of messages and users
  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  void initState() {
    super.initState();

    final history = serviceLocator<GlobalStorage>().chatHistory;
    setState(() {
      _messages.addAll(history.reversed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatbotAppBar(),
      body: DashChat(
        messages: _messages,
        currentUser: _currentUser,
        typingUsers: _typingUsers,
        messageOptions: MessageOptions(
          messagePadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
        inputOptions: InputOptions(
          sendButtonBuilder: defaultSendButton(
            icon: Icons.send_rounded,
            color: AppColors.primary,
            padding: EdgeInsets.only(
              left: 24.w,
            ),
          ),
          inputDecoration: InputDecoration(
            hintText: 'Nhập câu hỏi của bạn...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.grey[200],
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 10.h,
            ),
          ),
          inputToolbarPadding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: 12.h,
            top: 8.h,
          ),
          inputToolbarMargin: EdgeInsets.only(
            top: 8.h,
            left: 8.w,
            right: 8.w,
          ),
        ),
        onSend: (ChatMessage message) {
          getChatResponse(message);
        },
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage message) async {
    try {
      setState(() {
        _messages.insert(0, message);
        _typingUsers.add(_gptChatUser);
      });

      await serviceLocator<GlobalStorage>().addChatMessage(message);

      final response = await _dio.post(
        _webhookUrl,
        data: {
          'chatInput': message.text,
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
          content = 'Không thể xử lý phản hồi từ máy chủ.';
        }

        final botMessage = ChatMessage(
          user: _gptChatUser,
          createdAt: DateTime.now(),
          text: content,
          isMarkdown: true,
        );

        setState(() {
          _messages.insert(0, botMessage);
          _typingUsers.remove(_gptChatUser);
        });

        await serviceLocator<GlobalStorage>().addChatMessage(botMessage);
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
              message: 'Đã có lỗi xảy ra trong quá trình kết nối đến máy chủ.',
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
