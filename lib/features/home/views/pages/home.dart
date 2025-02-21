import 'package:flutter/material.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/pages/cart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/chatgpt_bot/views/pages/ai_chat.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/favorites/views/pages/my_favorites.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/get_started/views/pages/get_started.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/widgets/doctor_choice.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/widgets/for_your_health.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/pages/order_history.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/pages/all_product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/search/views/pages/search.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class HomePage extends StatelessWidget {
  final String displayName;

  const HomePage({super.key, required this.displayName});

  String get formattedDisplayName =>
      displayName.trim().split(' ').last.toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF43B73B),
              ),
              child: Center(
                child: Image.asset('assets/images/shop_logo.png'),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 10,
              ),
              leading: const Icon(Icons.home_rounded),
              title: const Text(
                'Trang chủ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              leading: const Icon(Icons.medication_liquid_rounded),
              title: const Text(
                'Tất cả sản phẩm',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AllProductPage(),
                  ),
                );
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              leading: const Icon(Icons.favorite_rounded),
              title: const Text(
                'Sản phẩm yêu thích',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyFavoritesPage(),
                  ),
                );
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              leading: const Icon(Icons.shopping_cart_rounded),
              title: const Text(
                'Giỏ hàng',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              leading: const Icon(Icons.receipt_rounded),
              title: const Text(
                'Hóa đơn',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OrderHistoryPage(),
                  ),
                );
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              leading: const Icon(Icons.chat_rounded),
              title: const Text(
                'Chat với AI',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AiChat(),
                  ),
                );
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              leading: const Icon(Icons.logout_rounded),
              title: const Text(
                'Đăng xuất',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () async {
                final signOutConfirmation = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'Đăng xuất',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: const Text(
                        'Bạn có chắc chắn muốn đăng xuất không?',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text(
                            'Không',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text(
                            'Có',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );

                if (signOutConfirmation == true) {
                  await serviceLocator<SignOutUseCase>().call();

                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const GetStartedPage(),
                      ),
                      (route) => false,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 40,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'CHÚC $formattedDisplayName\nNGÀY TỐT LÀNH!',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 40,
              ),
              child: TextField(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                    ),
                  );
                },
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'Tìm kiếm',
                  suffixIcon: Icon(Icons.search_rounded),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 40,
              ),
              child: _FirstRowButtons(),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 40,
              ),
              child: _SecondRowButtons(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 40,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/sale_banner.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 40,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'BÁC SĨ TIN DÙNG!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const DoctorChoice(),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 40,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'BẢO VỆ SỨC KHỎE CỦA BẠN!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const ForYourHealth(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _FirstRowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB2EBB8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                  size: 26,
                ),
                SizedBox(width: 10),
                Text(
                  'Giỏ hàng',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        Flexible(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AllProductPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFEC774),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Icon(
              Icons.medication_liquid_sharp,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}

class _SecondRowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AiChat(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFC9FFE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Icon(
              Icons.chat_bubble_outline_rounded,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Flexible(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrderHistoryPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB6EEF5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_outlined,
                  color: Colors.black,
                  size: 26,
                ),
                SizedBox(width: 10),
                Text(
                  'Hóa đơn',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
