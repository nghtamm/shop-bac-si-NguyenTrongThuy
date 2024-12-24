import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/image_display.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/product_display_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/product_display_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';

class DoctorChoice extends StatelessWidget {
  const DoctorChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDisplayCubit()..displayProducts(),
      child: BlocBuilder<ProductDisplayCubit, ProductDisplayState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductLoaded) {
            return _productCard(state.products);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _productCard(List<ProductEntity> products) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Row(
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
                        onPressed: () {},
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
                                products[index].title,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                products[index].shortDescription,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${products[index].price}đ',
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
                            products[index].images[0]),
                        height: 150,
                      ),
                    ),
                  ),
                ],
              ),
              if (index != products.length - 1) const SizedBox(width: 20),
            ],
          );
        },
      ),
    );
  }
}
