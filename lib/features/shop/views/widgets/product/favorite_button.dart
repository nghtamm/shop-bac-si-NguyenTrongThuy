import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/product/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/favorites/wishlist_item_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/bloc/product/products_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final ProductModel productModel;
  // final int? itemID;

  const FavoriteButton({
    super.key,
    required this.productModel,
    // this.itemID,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      buildWhen: (previous, current) => current is ProductsLoaded,
      builder: (context, state) {
        int? itemID;
        bool isFavorited = false;

        if (state is ProductsLoaded) {
          final match = state.favorites.firstWhere(
            (item) => item.productID == productModel.productID,
            orElse: () => WishlistItemModel(
              itemID: 0,
              productID: 0,
            ),
          );
          if (match.itemID != 0) {
            itemID = match.itemID;
            isFavorited = true;
          }
        }

        return IconButton(
          icon: Icon(
            isFavorited
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            color: isFavorited ? Colors.red : AppColors.black,
          ),
          onPressed: () {
            if (isFavorited) {
              context.read<ProductsBloc>().add(
                    FavoriteProductRemoved(
                      itemID: itemID!,
                    ),
                  );
            } else {
              context.read<ProductsBloc>().add(
                    FavoriteProductAdded(
                      productID: productModel.productID,
                    ),
                  );
            }

            ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                forceActionsBelow: true,
                content: AwesomeSnackbarContent(
                  title: 'Yêu thích',
                  message: 'Đã thêm sản phẩm vào danh sách yêu thích.',
                  contentType: ContentType.success,
                  inMaterialBanner: true,
                ),
                actions: const [
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
        );
      },
    );
  }
}
