import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/chatgpt_bot/views/pages/ai_chat.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  group('Kiểm thử tích hợp tính năng "Chat với AI"', () {
    testWidgets(
        'Kiểm thử chức năng người dùng gửi tin nhắn tới chatbot và nhận về phản hồi',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AiChat(),
        ),
      );
      await tester.pumpAndSettle();

      final textFieldFinder = find.byType(TextField);
      await tester.enterText(textFieldFinder, 'Hello, chatbot!');
      await tester.pumpAndSettle();

      final sendButtonFinder = find.byIcon(Icons.send);
      await tester.tap(sendButtonFinder);
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 20));
      expect(find.byType(TextContainer), findsWidgets);

      await tester.pump(const Duration(seconds: 20));
      expect(find.byType(TextContainer), findsWidgets);
    });

    testWidgets('Kiểm thử render giao diện', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AiChat(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Tư vấn sức khoẻ'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
