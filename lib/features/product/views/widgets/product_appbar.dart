import 'package:flutter/material.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/favorite_button.dart';

class ProductAppbar extends StatelessWidget implements PreferredSizeWidget {
  final ProductEntity productEntity;
  const ProductAppbar({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 15,
          right: 15,
          child: AppBar(
            backgroundColor: Colors.white,
            actions: <Widget>[
              FavoriteButton(productEntity: productEntity),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
              ),
            ],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
