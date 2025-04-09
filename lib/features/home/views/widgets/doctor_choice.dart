import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/app_routers.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/product/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/bloc/product/products_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/widgets/home_products_card.dart';

class DoctorChoice extends StatefulWidget {
  const DoctorChoice({super.key});

  @override
  State<DoctorChoice> createState() => _DoctorChoiceState();
}

class _DoctorChoiceState extends State<DoctorChoice> with RouteAware {
  bool _hasSyncedFavorites = false;

  @override
  void initState() {
    super.initState();

    context.read<ProductsBloc>().add(
          DoctorChoiceDisplayed(),
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
            DoctorChoiceDisplayed(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsBloc, ProductsState>(
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
            return _dcProducts(
              state.products,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _dcProducts(List<ProductModel> products) {
    return SizedBox(
      height: 300.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return HomeProductsCard(
            productModel: products[index],
          );
        },
      ),
    );
  }
}
