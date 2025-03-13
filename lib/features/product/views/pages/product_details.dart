import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/product_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/bloc/cart_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/add_to_cart_req.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/cubit/toggle_favorite_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_app_bar.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_image.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_price.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_title.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_description.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_quantity.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/cubit/product_quantity_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/image_helpers.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductDetailPage({
    required this.productEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) =>
              ToggleFavoriteCubit()..isFavorite(productEntity.productID),
        ),
      ],
      child: _productDetailsContent(
        productEntity: productEntity,
      ),
    );
  }

  Widget _productDetailsContent({required ProductEntity productEntity}) {
    return Builder(builder: (context) {
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
                ProductDescription(
                  productEntity: productEntity,
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      final cartBloc = context.read<CartBloc>();

                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider.value(
                            value: cartBloc,
                            child: BlocProvider(
                              create: (context) => ProductQuantityCubit(),
                              child: _bottomSheetContent(
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
    });
  }

  Widget _bottomSheetContent({required ProductEntity productEntity}) {
    return Builder(
      builder: (context) {
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
                        ImageHelpers.generateProductImageURL(
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
                      context.read<CartBloc>().add(
                            CartProductAdded(
                              requirements: AddToCartReq(
                                productID: productEntity.productID,
                                productTitle: productEntity.title,
                                productQuantity:
                                    context.read<ProductQuantityCubit>().state,
                                productPrice: productEntity.price.toInt(),
                                totalPrice: (ProductHelpers.provideCurrentPrice(
                                            productEntity) *
                                        context
                                            .read<ProductQuantityCubit>()
                                            .state)
                                    .toInt(),
                                productImage: productEntity.images[0],
                                createdDate: DateTime.now().toString(),
                              ),
                            ),
                          );

                      ScaffoldMessenger.of(context).showMaterialBanner(
                        const MaterialBanner(
                          forceActionsBelow: true,
                          content: AwesomeSnackbarContent(
                            title: 'Thêm vào giỏ hàng',
                            message:
                                'Đã thêm sản phẩm vào giỏ hàng thành công.',
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
            ),
          ),
        );
      },
    );
  }
}
