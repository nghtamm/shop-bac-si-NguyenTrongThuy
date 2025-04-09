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

class AllProductPage extends StatefulWidget {
  const AllProductPage({super.key});

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> with RouteAware {
  bool _hasSyncedFavorites = false;

  @override
  void initState() {
    super.initState();

    context.read<ProductsBloc>().add(
          AllProductsDisplayed(),
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
            AllProductsDisplayed(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        backgroundColor: AppColors.grayLight,
      ),
      body: BlocListener<ProductsBloc, ProductsState>(
        listenWhen: (previous, current) =>
            current is ProductsLoaded && !_hasSyncedFavorites,
        listener: (context, state) {
          if (state is ProductsLoaded) {
            _hasSyncedFavorites = true;
            context.read<ProductsBloc>().add(FavoritesSynced());
          }
        },
        child: BlocBuilder<ProductsBloc, ProductsState>(
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
                          'TẤT CẢ SẢN PHẨM',
                          style: AppTypography.black['32_extraBold'],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _products(
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
      ),
    );
  }

  Widget _products(List<ProductModel> products) {
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
