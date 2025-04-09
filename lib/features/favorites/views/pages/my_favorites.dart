import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/app_routers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/bloc/products_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/product_card.dart';

class MyFavoritesPage extends StatefulWidget {
  const MyFavoritesPage({super.key});

  @override
  State<MyFavoritesPage> createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> with RouteAware {
  @override
  void initState() {
    super.initState();

    context.read<ProductsBloc>().add(
          FavoritesDisplayed(),
        );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    observer.subscribe(
      this,
      ModalRoute.of(context)!,
    );
  }

  @override
  void dispose() {
    observer.unsubscribe(this);

    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsBloc>().add(
            FavoritesDisplayed(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    // final productsBloc = context.read<ProductsBloc>();
    // productsBloc.add(
    //   FavoritesDisplayed(),
    // );

    return Scaffold(
      appBar: const CustomAppBar(
        backgroundColor: AppColors.grayLight,
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ProductsLoaded) {
            return Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.grayLight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 5.h,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'SẢN PHẨM YÊU THÍCH CỦA BẠN',
                        style: AppTypography.black['32_extraBold'],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _favorites(
                    state.products,
                  ),
                ),
              ],
            );
          }

          return Container(
            color: AppColors.grayLight,
          );
        },
      ),
    );
  }

  Widget _favorites(List<ProductModel> products) {
    return Container(
      color: AppColors.grayLight,
      child: GridView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(
            productModel: products[index],
          );
        },
      ),
    );
  }
}
