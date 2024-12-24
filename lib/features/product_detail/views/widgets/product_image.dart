import 'package:flutter/material.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: double.infinity,
          child: Image.network(
            'https://example.com/your-image-url.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
