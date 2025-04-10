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
  final Dio _dio = Dio(BaseOptions(
    validateStatus: (status) => true, // Cho phép mọi trạng thái HTTP không ném ngoại lệ
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  ));
  final String _webhookUrl = 'https://fianetcele.app.n8n.cloud/webhook/cf3cfd9f-6c81-4a30-b736-39d58f3245d6/chat';
  
  // Tạo sessionId đơn giản bằng timestamp và số ngẫu nhiên
  final String _sessionId = '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(10000)}';

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
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          inputToolbarPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          inputToolbarMargin: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
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

      // Sử dụng chatInputKey và chatSessionKey theo cấu hình n8n
      final response = await _dio.post(
        _webhookUrl,
        data: {
          'chatInput': m.text,
          'sessionId': _sessionId,
          'metadata': {}
        },
      );

      print('Trạng thái phản hồi: ${response.statusCode}');
      print('Dữ liệu phản hồi: ${response.data}');

      if (response.statusCode == 200) {
        // Trích xuất nội dung từ phản hồi
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
            // Thử các trường phổ biến khác
            content = responseData['content'] ?? 
                      responseData['text'] ?? 
                      responseData['response'] ??
                      responseData['message'] ?? '';
          }
        } else if (responseData is String) {
          content = responseData;
        }
        
        // Nếu vẫn không tìm thấy nội dung
        if (content.isEmpty) {
          content = 'Không thể xử lý phản hồi từ máy chủ. Vui lòng thử lại.';
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
        // Xử lý lỗi HTTP
        print('Lỗi: ${response.statusCode} - ${response.statusMessage}');
        print('Phản hồi: ${response.data}');
        
        setState(() {
          _typingUsers.remove(_gptChatUser);
        });
        
        throw Exception('Lỗi từ server: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _typingUsers.remove(_gptChatUser);
      });
      
      if (mounted) {
        print(e.toString());
        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            forceActionsBelow: true,
            content: AwesomeSnackbarContent(
              title: 'Đã xảy ra lỗi',
              message: 'Vui lòng thử lại sau. Lỗi: Không thể kết nối đến máy chủ.',
              contentType: ContentType.failure,
              inMaterialBanner: true,
            ),
            actions: const [
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
