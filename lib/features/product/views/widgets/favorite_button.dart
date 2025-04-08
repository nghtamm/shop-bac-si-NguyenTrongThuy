import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/favorite_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/bloc/favorite_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/cubit/toggle_favorite_cubit.dart';

class FavoriteButton extends StatelessWidget {
  final ProductModel productModel;

  const FavoriteButton({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        print(state);

        bool isFavorite = false;

        if (state is FavoriteLoaded) {
          isFavorite = state.favorites
              .any((favorite) => favorite.productID == productModel.productID);
        }

        return IconButton(
          icon: BlocBuilder<ToggleFavoriteCubit, bool>(
            builder: (context, state) => Icon(
              state ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
            ),
          ),
          onPressed: () {
            final favoriteBloc = context.read<FavoriteBloc>();
            if (isFavorite) {
              favoriteBloc.add(RemoveFavorite(itemID: productModel.productID));
            } else {
              favoriteBloc.add(AddFavorite(
                favoriteModel: FavoriteModel(
                  productID: productModel.productID,
                  title: productModel.title,
                  permalink: productModel.permalink,
                  description: productModel.description,
                  shortDescription: productModel.shortDescription,
                  images: productModel.images,
                  price: productModel.price,
                  regularPrice: productModel.regularPrice,
                  salePrice: productModel.salePrice,
                ),
              ));
            }
            context.read<ToggleFavoriteCubit>().isFavorite(
                  productModel.productID.toString(),
                  favoriteBloc,
                );
            // context
            //     .read<ToggleFavoriteCubit>()
            //     .emit(!isFavorite); // Toggle the favorite state
            ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                forceActionsBelow: true,
                content: AwesomeSnackbarContent(
                  title: 'Yêu thích',
                  message: isFavorite
                      ? 'Đã xóa sản phẩm khỏi danh sách yêu thích.'
                      : 'Đã thêm sản phẩm vào danh sách yêu thích.',
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
