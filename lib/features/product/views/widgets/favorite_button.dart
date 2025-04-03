import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/cubit/toggle_favorite_cubit.dart';

class FavoriteButton extends StatelessWidget {
  final ProductModel productModel;

  const FavoriteButton({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: BlocBuilder<ToggleFavoriteCubit, bool>(
        builder: (context, state) => Icon(
          state ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
        ),
      ),
      onPressed: () {
        // final isFavorite = context.read<ToggleFavoriteCubit>().state;
        // context.read<ToggleFavoriteCubit>().onTap(productModel);

        // ScaffoldMessenger.of(context).showMaterialBanner(
        //   MaterialBanner(
        //     forceActionsBelow: true,
        //     content: AwesomeSnackbarContent(
        //       title: 'Yêu thích',
        //       message: isFavorite
        //           ? 'Đã xóa sản phẩm khỏi danh sách yêu thích.'
        //           : 'Đã thêm sản phẩm vào danh sách yêu thích.',
        //       contentType: ContentType.success,
        //       inMaterialBanner: true,
        //     ),
        //     actions: const [
        //       SizedBox.shrink(),
        //     ],
        //   ),
        // );
        // Future.delayed(const Duration(milliseconds: 1500), () {
        //   if (context.mounted) {
        //     ScaffoldMessenger.of(context).clearMaterialBanners();
        //   }
        // });
      },
    );
  }
}
