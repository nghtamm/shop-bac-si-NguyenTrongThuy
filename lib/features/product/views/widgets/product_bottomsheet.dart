import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/app_navigator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/product_price.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/pages/cart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/add_to_cart_req.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/add_to_cart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/bloc/button_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/bloc/button_state_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_quantity.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/bloc/product_quantity_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/image_display.dart';

class BottomSheetContent extends StatelessWidget {
  final ProductEntity productEntity;

  const BottomSheetContent({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ButtonStateCubit, ButtonState>(
      listener: (context, state) {
        if (state is ButtonSuccessState) {
          AppNavigator.push(context, const CartPage());
        }
        if (state is ButtonFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: SizedBox(
        height: 320.h,
        child: Padding(
          padding: EdgeInsets.only(
            top: 20.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 8.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      ImageDisplayHelper.generateProductImageURL(
                        productEntity.images[0],
                      ),
                      width: 100.w,
                      height: 100.h,
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productEntity.title,
                          style: AppTypography.black['20_bold'],
                        ),
                        Text(
                          '${productEntity.price}đ',
                          style: AppTypography.black['24_extraBold'],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              ProductQuantity(
                productEntity: productEntity,
              ),
              SizedBox(height: 4.h),
              Padding(
                padding: const EdgeInsets.all(30),
                child: ElevatedButton(
                  child: Text(
                    'THÊM VÀO GIỎ HÀNG',
                    style: AppTypography.white['24_extraBold'],
                  ),
                  onPressed: () {
                    context.read<ButtonStateCubit>().execute(
                          usecase: AddToCartUseCase(),
                          params: AddToCartReq(
                            productID: productEntity.productID,
                            productTitle: productEntity.title,
                            productQuantity:
                                context.read<ProductQuantityCubit>().state,
                            productPrice: productEntity.price.toInt(),
                            totalPrice: (ProductPriceHelper.provideCurrentPrice(
                                        productEntity) *
                                    context.read<ProductQuantityCubit>().state)
                                .toInt(),
                            productImage: productEntity.images[0],
                            createdDate: DateTime.now().toString(),
                          ),
                        );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
