import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/image_display.dart';

class ProductImages extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductImages({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: PageView.builder(
        controller: PageController(viewportFraction: 1),
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              width: 300.w,
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
        itemCount: productEntity.images.length,
      ),
    );
  }
}
