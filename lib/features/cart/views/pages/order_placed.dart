import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/auth_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/bloc/cart_bloc.dart';

class OrderPlacedPage extends StatelessWidget {
  const OrderPlacedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 40.w,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.delivered,
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
                BlocConsumer<CartBloc, CartState>(
                  listener: (context, state) {
                    if (state is CartDisposedSuccess) {
                      context.push(
                        RoutersName.homepage,
                        extra: state.displayName,
                      );
                    } else if (state is CartLoadFailure) {
                      ScaffoldMessenger.of(context).showMaterialBanner(
                        MaterialBanner(
                          forceActionsBelow: true,
                          content: AwesomeSnackbarContent(
                            title: 'Đã xảy ra lỗi',
                            message: state.message,
                            contentType: ContentType.failure,
                            inMaterialBanner: true,
                          ),
                          actions: const [
                            SizedBox.shrink(),
                          ],
                        ),
                      );
                      Future.delayed(const Duration(milliseconds: 1500), () {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).clearMaterialBanners();
                        }
                      });
                    }
                  },
                  builder: (context, state) {
                    String displayName = '';

                    final state = context.read<AuthBloc>().state;
                    if (state is Authenticated) {
                      displayName = state.displayName;
                    }

                    return ElevatedButton(
                      onPressed: () {
                        context.read<CartBloc>().add(
                              CartDisposed(
                                displayName: displayName,
                              ),
                            );
                      },
                      child: Text(
                        'QUAY LẠI TRANG CHỦ',
                        style: AppTypography.white['22_extraBold'],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
