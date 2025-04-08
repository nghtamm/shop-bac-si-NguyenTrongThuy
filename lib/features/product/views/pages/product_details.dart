import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/bloc/cart_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/repository/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/bloc/favorite_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/cubit/toggle_favorite_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_app_bar.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_image.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_price.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_title.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_description.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_quantity.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/cubit/product_quantity_cubit.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetailPage({
    required this.productModel,
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
              ToggleFavoriteCubit()..isFavorite(productModel.productID.toString(), context.read<FavoriteBloc>()
              ),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(
            productRepository: context.read<ProductRepository>(),
          ),
        ),
      ],
      child: _productDetailsContent(
        productModel: productModel,
      ),
    );
  }

  Widget _productDetailsContent({required ProductModel productModel}) {
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: ProductAppbar(
          productModel: productModel,
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
                  productModel: productModel,
                ),
                SizedBox(height: 60.h),
                ProductTitle(
                  productModel: productModel,
                ),
                SizedBox(height: 10.h),
                ProductPrice(
                  productModel: productModel,
                ),
                SizedBox(height: 20.h),
                ProductDescription(
                  productModel: productModel,
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
                                productModel: productModel,
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

  Widget _bottomSheetContent({required ProductModel productModel}) {
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
                        productModel.images[0],
                        width: 100.w,
                        height: 100.h,
                      ),
                      SizedBox(width: 16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productModel.title,
                            style: AppTypography.black['20_bold'],
                          ),
                          Text(
                            '${productModel.price}đ',
                            style: AppTypography.black['24_extraBold'],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                ProductQuantity(
                  productModel: productModel,
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
                      // context.read<CartBloc>().add(
                      //       CartProductAdded(
                      //         requirements: AddToCartReq(
                      //           productID: productEntity.productID,
                      //           productTitle: productEntity.title,
                      //           productQuantity:
                      //               context.read<ProductQuantityCubit>().state,
                      //           productPrice: productEntity.price.toInt(),
                      //           totalPrice: (ProductHelpers.provideCurrentPrice(
                      //                       productEntity) *
                      //                   context
                      //                       .read<ProductQuantityCubit>()
                      //                       .state)
                      //               .toInt(),
                      //           productImage: productEntity.images[0],
                      //           createdDate: DateTime.now().toString(),
                      //         ),
                      //       ),
                      //     );

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
