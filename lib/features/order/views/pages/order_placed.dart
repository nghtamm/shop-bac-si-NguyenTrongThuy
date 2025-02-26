import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/get_started/views/bloc/auth_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/get_started/views/bloc/auth_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/dispose_cart_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class OrderPlacedPage extends StatelessWidget {
  const OrderPlacedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/order_placed.png',
                width: 180.w,
                height: 180.h,
              ),
              const SizedBox(height: 10),
              Text(
                'Chúng tôi sẽ giao hàng tới bạn sớm nhất có thể!',
                style: AppTypography.black['22_semiBold'],
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h),
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

                      context.push(
                        RoutersName.homepage,
                        extra: displayName,
                      );
                    },
                  );
                },
                child: Text(
                  'QUAY LẠI TRANG CHỦ',
                  style: AppTypography.white['22_extraBold'],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
