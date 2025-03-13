import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/bloc/products_bloc.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      onChanged: (searchValue) {
        if (searchValue.isEmpty) {
          context.read<ProductsBloc>().add(
                SearchProductsDisplayed(
                  query: '',
                ),
              );
        } else {
          context.read<ProductsBloc>().add(
                SearchProductsDisplayed(
                  query: searchValue,
                ),
              );
        }
      },
      decoration: InputDecoration(
        hintText: 'Nhập tên sản phẩm',
        suffixIcon: const Icon(Icons.search_rounded),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 15.w,
        ),
      ),
    );
  }
}
