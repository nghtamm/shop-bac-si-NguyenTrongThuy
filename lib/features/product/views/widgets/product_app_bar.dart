import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/favorite_button.dart';

class ProductAppbar extends StatelessWidget implements PreferredSizeWidget {
  final ProductModel productModel;

  const ProductAppbar({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10.h,
          left: 15.w,
          right: 15.w,
          child: AppBar(
            backgroundColor: AppColors.white,
            actions: <Widget>[
              FavoriteButton(
                productModel: productModel,
              ),
              IconButton(
                icon: const Icon(
                  Icons.share,
                ),
                onPressed: () {},
              ),
            ],
            leading: IconButton(
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
