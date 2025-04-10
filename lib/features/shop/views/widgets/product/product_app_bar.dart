import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/product/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/widgets/product/favorite_button.dart';

class ProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ProductModel productModel;

  const ProductAppBar({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          backgroundColor: AppColors.white,
          actions: <Widget>[
            Transform.translate(
              offset: Offset(-8.w, 12.h),
              child: FavoriteButton(
                productModel: productModel,
              ),
            ),
            Transform.translate(
              offset: Offset(-8.w, 12.h),
              child: IconButton(
                icon: const Icon(
                  Icons.share,
                ),
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: productModel.permalink,
                    ),
                  );

                  ScaffoldMessenger.of(context).showMaterialBanner(
                    const MaterialBanner(
                      forceActionsBelow: true,
                      content: AwesomeSnackbarContent(
                        title: 'Chia sẻ',
                        message:
                            'Đã sao chép liên kết sản phẩm vào bộ nhớ tạm!',
                        contentType: ContentType.success,
                        inMaterialBanner: true,
                      ),
                      actions: [
                        SizedBox.shrink(),
                      ],
                    ),
                  );
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).clearMaterialBanners();
                    }
                  });
                },
              ),
            ),
          ],
          leading: Transform.translate(
            offset: Offset(8.w, 12.h),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
