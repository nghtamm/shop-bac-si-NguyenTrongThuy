import 'package:flutter/material.dart';

class AiChatTextbox extends StatelessWidget {
  final TextEditingController textController;
  final Function(String) onSend;

  AiChatTextbox({required this.textController, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white, // Màu nền của Bottom Navigation Bar
      shape: CircularNotchedRectangle(), // Hình dạng bo góc (tùy chọn)
      notchMargin: 6, // Khoảng cách giữa nút nổi và viền
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 0.0),
        child: Row(
          children: [
            // TextField với thiết kế bo góc
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Màu nền của TextField
                  borderRadius: BorderRadius.circular(60), // Bo góc
                ),
                child: TextField(
                  controller: textController, // Controller nhận từ bên ngoài
                  decoration: InputDecoration(
                    hintText: "Nhập nội dung", // Placeholder
                    hintStyle:
                        TextStyle(color: Colors.grey), // Màu chữ Placeholder
                    border: InputBorder.none, // Xóa viền mặc định
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10), // Khoảng cách giữa TextField và nút
            // Nút hình tròn
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.green, // Màu nền của nút
              ),
              child: IconButton(
                icon: Icon(
                  Icons.send, // Icon mũi tên
                  color: Colors.white, // Màu icon
                ),
                onPressed: () {
                  onSend(textController.text); // Gọi hàm xử lý khi nhấn nút
                  textController.clear(); // Xóa nội dung trong TextField
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
