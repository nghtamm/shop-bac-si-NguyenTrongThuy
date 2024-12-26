import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/appnavigator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/product_price.dart';
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
        height: 320,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
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
                            totalPrice: (ProductPriceHelper.provideCurrentPrice(
                                        productEntity) *
                                    context.read<ProductQuantityCubit>().state)
                                .toDouble(),
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
