import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/app_routers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/bloc/product/products_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/product_card.dart';

class AllProductPage extends StatefulWidget {
  const AllProductPage({super.key});

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> with RouteAware {
  final ScrollController _scrollController = ScrollController();
  bool _hasSyncedFavorites = false;

  @override
  void initState() {
    super.initState();

    context.read<ProductsBloc>().add(
          AllProductsDisplayed(
            page: 1,
          ),
        );
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final bloc = context.read<ProductsBloc>();
    final state = bloc.state;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      if (state is ProductsLoaded && !state.hasReachedMax) {
        bloc.add(
          AllProductsDisplayed(
            page: bloc.currentPage + 1,
          ),
        );
      }
    }
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
    _scrollController.dispose();

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
        backgroundColor: AppColors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
                vertical: 20.h,
              ),
              child: Text(
                'TẤT CẢ SẢN PHẨM',
                style: AppTypography.black['32_extraBold'],
              ),
            ),
          ),
          Expanded(
            child: BlocListener<ProductsBloc, ProductsState>(
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
                  final isLoading = state is ProductsLoading;
                  final products =
                      state is ProductsLoaded ? state.products : [];

                  return CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      if (!isLoading || products.isNotEmpty)
                        SliverToBoxAdapter(
                          child: Container(
                            color: AppColors.grayLight,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: products.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10.h,
                                  crossAxisSpacing: 10.w,
                                  childAspectRatio: 0.6,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return ProductCard(
                                    productModel: products[index],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      if (state is ProductsLoaded && !state.hasReachedMax)
                        SliverToBoxAdapter(
                          child: Container(
                            color: AppColors.grayLight,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 30.h),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                      if (isLoading && products.isEmpty)
                        const SliverFillRemaining(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
