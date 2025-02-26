import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/bloc/toggle_favorite_cubit.dart';

class FavoriteButton extends StatelessWidget {
  final ProductEntity productEntity;

  const FavoriteButton({
    super.key,
    required this.productEntity,
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
        final isFavorite = context.read<ToggleFavoriteCubit>().state;
        context.read<ToggleFavoriteCubit>().onTap(productEntity);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isFavorite
                  ? 'Đã xóa sản phẩm khỏi danh sách yêu thích.'
                  : 'Đã thêm sản phẩm vào danh sách yêu thích.',
            ),
          ),
        );
      },
    );
  }
}
