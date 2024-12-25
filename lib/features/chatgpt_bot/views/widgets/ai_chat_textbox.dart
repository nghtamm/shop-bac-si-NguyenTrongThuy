import 'package:flutter/material.dart';

class AiChatTextbox extends StatelessWidget {
  final TextEditingController textController;
  final Function(String) onSend;

  const AiChatTextbox(
      {super.key, required this.textController, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 0.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: "Nhập nội dung",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 20,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.green,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: () {
                  onSend(textController.text);
                  textController.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
