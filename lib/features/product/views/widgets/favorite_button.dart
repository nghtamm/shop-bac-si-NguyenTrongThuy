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
        context.read<ToggleFavoriteCubit>().onTap(productEntity);
      },
    );
  }
}
