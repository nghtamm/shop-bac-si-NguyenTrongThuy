import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product_model.dart';

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
            child: Container(
              width: 300.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    productModel.images[index],
                  ),
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
