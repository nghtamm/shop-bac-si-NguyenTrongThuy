import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/app_routers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/text_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/bloc/cart/cart_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/order/cart_item_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/order/add_to_cart_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/product/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/cubit/product_option_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/widgets/product/product_app_bar.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/widgets/product/product_image.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/widgets/product/product_price.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/widgets/product/product_title.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/widgets/product/product_description.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/widgets/product/product_quantity.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/cubit/product_quantity_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/bloc/product/products_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailPage({
    required this.productModel,
    super.key,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> with RouteAware {
  @override
  void initState() {
    super.initState();

    context.read<ProductsBloc>().add(
          VariationsDisplayed(
            productID: widget.productModel.productID.toString(),
          ),
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
            VariationsDisplayed(
              productID: widget.productModel.productID.toString(),
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    // int? itemID;
    // final state = context.read<ProductsBloc>().state;
    // if (state is ProductsLoaded) {
    //   final match = state.favorites.firstWhere(
    //     (item) => item.productID == productModel.productID,
    //     orElse: () => WishlistItemModel(
    //       itemID: 0,
    //       productID: 0,
    //     ),
    //   );
    //   if (match.itemID != 0) {
    //     itemID = match.itemID;
    //   }
    // }

    // final productsBloc = context.read<ProductsBloc>();
    // productsBloc.add(VariationsDisplayed(
    //   productID: widget.productModel.productID.toString(),
    // ));

    return LoaderOverlay(
      child: BlocProvider(
        create: (context) => CartBloc(),
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }

            return _productDetailsContent(
              productModel: widget.productModel,
            );
          },
        ),
      ),
    );
  }

  Widget _productDetailsContent({
    required ProductModel productModel,
  }) {
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: ProductAppBar(
            productModel: productModel,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 50.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductImages(
                        productModel: productModel,
                      ),
                      SizedBox(height: 60.h),
                      ProductTitle(
                        productModel: productModel,
                      ),
                      SizedBox(height: 10.h),
                      ProductPrice(
                        productModel: productModel,
                      ),
                      SizedBox(height: 20.h),
                      ProductDescription(
                        productModel: productModel,
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),

              // PRODUCT: Add to Cart
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20.h,
                    left: 30.w,
                    right: 30.w,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      final cartBloc = context.read<CartBloc>();
                      final productsBloc = context.read<ProductsBloc>();

                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider.value(
                            value: productsBloc,
                            child: BlocProvider.value(
                              value: cartBloc,
                              child: MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) => ProductQuantityCubit(),
                                  ),
                                  BlocProvider(
                                    create: (context) => ProductOptionCubit(
                                      initialIndex: 0,
                                      optionsCount: productModel.options.length,
                                    ),
                                  ),
                                ],
                                child: _bottomSheetContent(
                                  productModel: productModel,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      'LỰA CHỌN SẢN PHẨM',
                      style: AppTypography.white['24_extraBold'],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _bottomSheetContent({
    required ProductModel productModel,
  }) {
    return Builder(
      builder: (context) {
        return SizedBox(
          height: productModel.options.isNotEmpty ? 0.5.sh : 0.4.sh,
          child: Padding(
            padding: EdgeInsets.only(
              top: 20.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // PRODUCT: Overview (Image, Title, Price)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                        productModel.images[0],
                        width: 100.w,
                        height: 100.h,
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productModel.title,
                              style: AppTypography.black['20_bold'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            BlocBuilder<ProductOptionCubit, int>(
                              builder: (context, state) {
                                return BlocBuilder<ProductsBloc, ProductsState>(
                                  builder: (context, state) {
                                    String currentPrice = productModel.price;
                                    final selectedIndex = context
                                        .read<ProductOptionCubit>()
                                        .state;

                                    if (state is ProductsLoaded &&
                                        state.variations.isNotEmpty) {
                                      final variation =
                                          state.variations[selectedIndex];
                                      currentPrice =
                                          variation.salePrice?.isNotEmpty ==
                                                  true
                                              ? variation.salePrice!
                                              : variation.price;
                                    }

                                    return Text(
                                      TextHelpers()
                                          .formatVNCurrency(currentPrice),
                                      style:
                                          AppTypography.black['24_extraBold'],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),

                // PRODUCT: Options
                if (productModel.options.isNotEmpty) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 28.w,
                        ),
                        child: Text(
                          'Liệu trình',
                          style: AppTypography.black['20_bold'],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Builder(
                        builder: (context) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28.w,
                            ),
                            height: 50.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: productModel.options.length,
                              itemBuilder: (context, index) {
                                return BlocBuilder<ProductOptionCubit, int>(
                                  builder: (context, selectedIndex) {
                                    final isSelected = selectedIndex == index;

                                    return Padding(
                                      padding: EdgeInsets.only(right: 8.w),
                                      child: OutlinedButton(
                                        onPressed: () {
                                          context
                                              .read<ProductOptionCubit>()
                                              .selectOption(index);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: isSelected
                                              ? AppColors.primary
                                              : AppColors.white,
                                          foregroundColor: isSelected
                                              ? AppColors.white
                                              : AppColors.black,
                                          side: BorderSide.none,
                                        ),
                                        child: Text(
                                          productModel.options[index],
                                          style: isSelected
                                              ? AppTypography
                                                  .white['20_semiBold']
                                              : AppTypography
                                                  .black['20_semiBold'],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(width: 6.w),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],

                // PRODUCT: Quantity
                SizedBox(height: 24.h),
                ProductQuantity(
                  productModel: productModel,
                ),

                // PRODUCT: Add to Cart
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: ElevatedButton(
                    child: Text(
                      'THÊM VÀO GIỎ HÀNG',
                      style: AppTypography.white['24_extraBold'],
                    ),
                    onPressed: () async {
                      final selectedOptionIndex =
                          context.read<ProductOptionCubit>().state;
                      final quantity =
                          context.read<ProductQuantityCubit>().state;

                      final productsState = context.read<ProductsBloc>().state;
                      String currentPrice = productModel.price;
                      if (productsState is ProductsLoaded &&
                          productsState.variations.length >
                              selectedOptionIndex) {
                        final variation =
                            productsState.variations[selectedOptionIndex];
                        currentPrice = variation.salePrice?.isNotEmpty == true
                            ? variation.salePrice!
                            : variation.price;
                      }

                      final cartItem = CartItemModel(
                        productID: productModel.productID,
                        title: productModel.title,
                        image: productModel.images[0],
                        price: currentPrice,
                        options: productModel.options.isNotEmpty
                            ? productModel.options[selectedOptionIndex]
                            : '',
                        optionsID: productModel.options.isNotEmpty &&
                                productModel.options.length > 1
                            ? productModel.optionsID[selectedOptionIndex]
                            : null,
                        quantity: quantity,
                      );

                      await serviceLocator<AddToCartUseCase>().call(
                        params: cartItem,
                      );

                      if (context.mounted) {
                        context.pop();

                        ScaffoldMessenger.of(context).showMaterialBanner(
                          const MaterialBanner(
                            forceActionsBelow: true,
                            content: AwesomeSnackbarContent(
                              title: 'Thêm vào giỏ hàng',
                              message: 'Đã thêm sản phẩm vào giỏ hàng!',
                              contentType: ContentType.success,
                              inMaterialBanner: true,
                            ),
                            actions: [
                              SizedBox.shrink(),
                            ],
                          ),
                        );
                        Future.delayed(const Duration(milliseconds: 1500), () {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .clearMaterialBanners();
                          }
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
