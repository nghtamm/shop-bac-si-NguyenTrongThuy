import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/product/product_model.dart';

class ProductImages extends StatelessWidget {
  final ProductModel productModel;

  const ProductImages({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 1,
        ),
        itemBuilder: (context, index) {
          return Center(
            child: SizedBox(
              width: 300.w,
              child: CachedNetworkImage(
                imageUrl: productModel.images[index],
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                ),
              ),
            ),
          );
        },
        itemCount: productModel.images.length,
      ),
    );
  }
}
