import 'package:flutter/material.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/image_display.dart';

class ProductImages extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductImages({Key? key, required this.productEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    ImageDisplayHelper.generateProductImageURL(
                      productEntity.images[index],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: productEntity.images.length,
      ),
    );
  }
}
