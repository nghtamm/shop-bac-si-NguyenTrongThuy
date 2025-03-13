import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/cubit/product_quantity_cubit.dart';

class ProductQuantity extends StatelessWidget {
  final ProductEntity productEntity;

<<<<<<< HEAD
  const ProductQuantity({required this.productEntity, super.key});
=======
  const ProductQuantity({
    required this.productEntity,
    super.key,
  });
>>>>>>> nghtamm2003/refactor

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      padding: EdgeInsets.only(
        left: 12.w,
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
<<<<<<< HEAD
                    onPressed: () {
                      context.read<ProductQuantityCubit>().decrement();
                    },
                    icon: Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.remove,
                          size: 30,
                        ),
                      ),
                    )),
=======
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
                        Icons.remove,
                        size: 30,
                      ),
                    ),
                  ),
                ),
>>>>>>> nghtamm2003/refactor
                SizedBox(width: 10.w),
                BlocBuilder<ProductQuantityCubit, int>(
                  builder: (context, state) => Text(
                    state.toString(),
                    style: AppTypography.black['18_bold'],
                  ),
                ),
                SizedBox(width: 10.w),
                IconButton(
<<<<<<< HEAD
                  onPressed: () {
                    context.read<ProductQuantityCubit>().increment();
                  },
=======
                  onPressed: () =>
                      context.read<ProductQuantityCubit>().increment(),
>>>>>>> nghtamm2003/refactor
                  icon: Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
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
