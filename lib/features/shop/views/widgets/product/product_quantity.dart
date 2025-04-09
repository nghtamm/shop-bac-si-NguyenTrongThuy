import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/product/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/cubit/product_quantity_cubit.dart';

class ProductQuantity extends StatelessWidget {
  final ProductModel productModel;

  const ProductQuantity({
    required this.productModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(
        horizontal: 28.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Số lượng',
            style: AppTypography.black['20_bold'],
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () =>
                      context.read<ProductQuantityCubit>().decrement(),
                  icon: Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.remove_rounded,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                BlocBuilder<ProductQuantityCubit, int>(
                  builder: (context, state) => Text(
                    state.toString(),
                    style: AppTypography.black['18_bold'],
                  ),
                ),
                SizedBox(width: 10.w),
                IconButton(
                  onPressed: () =>
                      context.read<ProductQuantityCubit>().increment(),
                  icon: Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add_rounded,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
