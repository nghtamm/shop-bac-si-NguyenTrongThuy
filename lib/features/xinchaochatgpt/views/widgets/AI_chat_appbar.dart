import 'package:flutter/material.dart';

class AiChatAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AiChatAppbar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 1, // Để có viền mờ nhẹ

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,

            color: Colors.black, // Màu của nút back
          ),
          onPressed: () {
            // Xử lý khi nhấn nút back
          },
        ),

        title: Row(
          children: [
            CircleAvatar(
              radius: 22, // Kích thước avatar

              backgroundImage: Image.asset(
                'assets/images/capybara.png', // Thay bằng link ảnh thật
              ).image,
            ),

            const SizedBox(width: 14), // Khoảng cách giữa avatar và text

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Tư vấn sức khoẻ',
                  style: TextStyle(
                    color: Colors.black, // Màu chữ tiêu đề

                    fontSize: 18,

                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Chuột lang nước',
                  style: TextStyle(
                    color: Colors.grey, // Màu chữ phụ

                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
