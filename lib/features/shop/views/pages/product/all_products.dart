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
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.w,
                        vertical: 5.h,
                      ),
                      child: Text(
                        'TẤT CẢ SẢN PHẨM',
                        style: AppTypography.black['32_extraBold'],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ProductCard(
                            productModel: state.products[index],
                          );
                        },
                        childCount: state.products.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 10.w,
                        childAspectRatio: 0.6,
                      ),
                    ),
                  ),
                  if (!state.hasReachedMax)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 30.h,
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
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
}
