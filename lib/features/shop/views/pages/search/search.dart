import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/app_routers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/product/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/widgets/search/search_field.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/widgets/search/search_not_found.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/bloc/product/products_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/product_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with RouteAware {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<ProductsBloc>().add(
          SearchProductsDisplayed(query: ''),
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
            SearchProductsDisplayed(query: ''),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        toolbarHeight: 80.h,
        leading: Transform.translate(
          offset: Offset(6.w, 0.h),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 24,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        title: SearchField(
          searchController: _searchController,
        ),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductsLoaded) {
            return state.products.isEmpty
                ? const SearchNotFound()
                : _searchProducts(
                    state.products,
                  );
          }
          return Container(
            color: AppColors.grayLight,
          );
        },
      ),
    );
  }

  Widget _searchProducts(List<ProductModel> products) {
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
