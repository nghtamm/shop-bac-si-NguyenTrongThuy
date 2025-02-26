import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/product_price.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/add_to_cart_req.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/add_to_cart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/bloc/button_state_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/bloc/toggle_favorite_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_appbar.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_image.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_price.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_title.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_desc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_quantity.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/bloc/product_quantity_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/image_display.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductDetailPage({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ButtonStateCubit(),
        ),
        BlocProvider(
          create: (context) =>
              ToggleFavoriteCubit()..isFavorite(productEntity.productID),
        ),
      ],
      child: ProductDetailContent(productEntity: productEntity),
    );
  }
}

class ProductDetailContent extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductDetailContent({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ProductAppbar(
        productEntity: productEntity,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 30.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImages(
                productEntity: productEntity,
              ),
              SizedBox(height: 60.h),
              ProductTitle(
                productEntity: productEntity,
              ),
              SizedBox(height: 10.h),
              ProductPrice(
                productEntity: productEntity,
              ),
              SizedBox(height: 20.h),
              ProductDesc(
                productEntity: productEntity,
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    final buttonCubit = context.read<ButtonStateCubit>();
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return BlocProvider.value(
                          value: buttonCubit,
                          child: BlocProvider(
                            create: (context) => ProductQuantityCubit(),
                            child: BottomSheetContent(
                              productEntity: productEntity,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'LỰA CHỌN SẢN PHẨM',
                    style: AppTypography.white['24_extraBold'],
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

class BottomSheetContent extends StatelessWidget {
  final ProductEntity productEntity;

  const BottomSheetContent({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                left: 10.w,
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Đã thêm sản phẩm vào giỏ hàng thành công.'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
