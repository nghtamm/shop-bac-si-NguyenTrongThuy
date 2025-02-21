import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/models/auth_request.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/get_display_name_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/toggle_password_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/forgot_password.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/pages/home.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                'MUA HÀNG NGAY',
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
                'Đăng nhập tài khoản để được mua hàng tại Shop Bác sĩ Nguyễn Trọng Thủy',
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
            const SizedBox(height: 10),
            BlocBuilder<TogglePasswordCubit, bool>(
              builder: (context, isVisible) {
                return TextField(
                  controller: _passwordController,
                  obscureText: !isVisible,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z0-9!@#$%^&*()\-_=+<>?]'),
                    ),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Mật khẩu',
                    prefixIcon: const Icon(Icons.password_rounded),
                    suffixIcon: GestureDetector(
                      onTap: () => context
                          .read<TogglePasswordCubit>()
                          .toggleVisibility(),
                      child: Icon(isVisible
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                var result = await serviceLocator<SignInUseCase>().call(
                  params: AuthenticationRequest(
                    email: _emailController.text.toString(),
                    password: _passwordController.text.toString(),
                  ),
                );
                result.fold(
                  (left) {
                    var snackBar = SnackBar(
                      content: Text(left),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  (right) async {
                    var displayName =
                        await serviceLocator<GetDisplayNameUseCase>().call();

                    if (context.mounted) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              HomePage(displayName: displayName),
                        ),
                        (route) => false,
                      );
                    }
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
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => ForgotPasswordPage(),
                  ),
                );
              },
              child: const Text(
                'Quên mật khẩu?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
