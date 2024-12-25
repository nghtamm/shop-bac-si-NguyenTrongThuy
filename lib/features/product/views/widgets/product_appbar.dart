import 'package:flutter/material.dart';

class ProductAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ProductAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 15,
          right: 15,
          child: AppBar(
            backgroundColor: Colors.white,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.ios_share),
                onPressed: () {},
              ),
            ],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
