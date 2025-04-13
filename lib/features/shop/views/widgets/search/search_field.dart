import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/bloc/product/products_bloc.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget._searchController.addListener(() {
      setState(() {
        _hasText = widget._searchController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._searchController,
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
        suffixIcon: _hasText
            ? IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                ),
                onPressed: () {
                  widget._searchController.clear();
                  context.read<ProductsBloc>().add(
                        SearchProductsDisplayed(
                          query: '',
                        ),
                      );
                },
              )
            : const Icon(
                Icons.search_rounded,
              ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 15.w,
        ),
      ),
    );
  }
}
