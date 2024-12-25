import 'package:flutter/material.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/service_locator.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 40,
        ),
        child: Column(
          children: [
            const Spacer(),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'QUÊN MẬT KHẨU',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nhập email của bạn để có thể đặt lại mật khẩu nhé!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Địa chỉ Email',
                prefixIcon: Icon(Icons.email_rounded),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                var result = await serviceLocator<ResetPasswordUseCase>().call(
                  params: _emailController.text.toString(),
                );
                result.fold(
                  (left) {
                    var snackBar = SnackBar(
                      content: Text(left),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  (right) {
                    var snackBar = SnackBar(
                      content: Text(right),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    Navigator.of(context).pop();
                  },
                );
              },
              child: const Text(
                'TIẾP TỤC',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
