import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/api_client_example/product_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/api_client_example/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()
        ..add(
          FetchProductsEvent(),
        ),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: Text('Sản phẩm'),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Đã xảy ra lỗi:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.errorMessage,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProductBloc>().add(FetchProductsEvent());
                      },
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              );
            } else if (state is ProductLoadedState) {
              return state.products.isEmpty
                  ? const Center(child: Text('Không có sản phẩm nào'))
                  : RefreshIndicator(
                      onRefresh: () async {
                        context.read<ProductBloc>().add(FetchProductsEvent());
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return ProductListItem(
                              product: state.products[index]);
                        },
                      ),
                    );
            }

            // Initial
            return const Center(
              child: Text('Vui lòng đợi...'),
            );
          },
        ),
      ),
    );
  }
}

class ProductListItem extends StatelessWidget {
  final ProductModel product;

  const ProductListItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          product.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Giá: \$${product.price}',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // Có thể mở permalink trong webview hoặc trình duyệt
              },
              child: Text(
                product.permalink,
                style: TextStyle(
                  color: Colors.blue[700],
                  decoration: TextDecoration.underline,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        onTap: () {
          // Có thể điều hướng đến trang chi tiết sản phẩm
        },
      ),
    );
  }
}
