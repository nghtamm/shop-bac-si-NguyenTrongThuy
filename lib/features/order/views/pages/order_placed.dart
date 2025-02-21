import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/get_started/views/bloc/auth_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/get_started/views/bloc/auth_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/pages/home.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/dispose_cart_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class OrderPlacedPage extends StatelessWidget {
  const OrderPlacedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/order_placed.png',
                width: 180,
                height: 180,
              ),
              const SizedBox(height: 10),
              const Text(
                'Chúng tôi sẽ giao hàng tới bạn sớm nhất có thể!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final result =
                      await serviceLocator<DisposeCartUseCase>().call();
                  result.fold(
                    (left) {
                      var snackBar = SnackBar(content: Text(left));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    (right) {
                      String displayName = '';
                      final state = context.read<AuthenticationCubit>().state;
                      if (state is Authenticated) {
                        displayName = state.displayName;
                      }

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              HomePage(displayName: displayName),
                        ),
                      );
                    },
                  );
                },
                child: const Text(
                  'QUAY LẠI TRANG CHỦ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
