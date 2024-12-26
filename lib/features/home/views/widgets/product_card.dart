import 'package:flutter/material.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/app_navigator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/image_display.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/pages/product_detail.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductCard({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(
          context,
          ProductDetailPage(
            productEntity: productEntity,
          ),
        );
      },
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: SizedBox(
                  height: 220,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      AppNavigator.push(
                        context,
                        ProductDetailPage(
                          productEntity: productEntity,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFAECEFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 80),
                          Text(
                            productEntity.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            productEntity.shortDescription,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${productEntity.price}đ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Image.network(
                    ImageDisplayHelper.generateProductImageURL(
                        productEntity.images[0]),
                    height: 150,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
