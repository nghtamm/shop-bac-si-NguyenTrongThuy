import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/product/product_model.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductDescription extends StatelessWidget {
  final ProductModel productModel;

  const ProductDescription({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
      ),
      child: Html(
        data: productModel.description,
        style: {
          "body": Style(
            fontSize: FontSize(16),
            color: AppColors.black,
            textAlign: TextAlign.justify,
          ),
        },
      ),
    );
  }
}
