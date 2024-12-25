import 'package:flutter/material.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/get_display_name_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/google_sign_in_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/sign_in.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/sign_up.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/pages/home.dart';
import 'package:shop_bacsi_nguyentrongthuy/service_locator.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'XIN CHÀO!',
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
                'Lựa chọn đăng ký hoặc đăng nhập để tiếp tục',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => SignUpPage(),
                  ),
                );
              },
              child: const Text(
                'ĐĂNG KÝ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => SignInPage(),
                  ),
                );
              },
              child: const Text(
                'ĐĂNG NHẬP',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'hoặc đăng nhập với',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            _AuthenticationSocialButtons(),
            const Spacer(),
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 30,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Thỏa thuận người dùng (EULA)',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Nội dung thỏa thuận người dùng sẽ được hiển thị ở đây. '
                            'Đảm bảo rằng người dùng đọc và hiểu các điều khoản.',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(100, 50),
                              ),
                              child: const Text(
                                'TÔI ĐÃ HIỂU',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text(
                'Thỏa thuận người dùng (EULA)',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthenticationSocialButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () async {
            var result = await serviceLocator<GoogleSignInUseCase>().call();
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
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE5EAF4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: const Size(90, 50),
          ),
          child: Image.asset(
            'assets/images/google_icon.png',
            height: 30,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE5EAF4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: const Size(90, 50),
          ),
          child: Image.asset(
            'assets/images/apple_icon.png',
            height: 30,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE5EAF4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: const Size(90, 50),
          ),
          child: Image.asset(
            'assets/images/facebook_icon.png',
            height: 30,
          ),
        ),
      ],
    );
  }
}
