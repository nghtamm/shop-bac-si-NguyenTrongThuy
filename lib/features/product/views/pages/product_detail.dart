import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/product_price.dart';
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
      backgroundColor: Colors.white,
      appBar: ProductAppbar(productEntity: productEntity),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImages(productEntity: productEntity),
              const SizedBox(height: 60),
              ProductTitle(productEntity: productEntity),
              const SizedBox(height: 10),
              ProductPrice(productEntity: productEntity),
              const SizedBox(height: 20),
              ProductDesc(productEntity: productEntity),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
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
                                productEntity: productEntity),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text(
                    'LỰA CHỌN SẢN PHẨM',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
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
      height: 320,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                    ImageDisplayHelper.generateProductImageURL(
                      productEntity.images[0],
                    ),
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productEntity.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${productEntity.price}đ',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            ProductQuantity(productEntity: productEntity),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                child: const Text(
                  'THÊM VÀO GIỎ HÀNG',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  context.read<ButtonStateCubit>().execute(
                        usecase: AddToCartUseCase(),
                        params: AddToCartReq(
                          productID: productEntity.productID,
                          productTitle: productEntity.title,
                          productQuantity:
                              context.read<ProductQuantityCubit>().state,
                          productPrice: productEntity.price.toDouble(),
                          totalPrice: ProductPriceHelper.provideCurrentPrice(
                                  productEntity) *
                              context.read<ProductQuantityCubit>().state,
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
    );
  }
}
