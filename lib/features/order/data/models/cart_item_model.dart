class CartItemModel {
  final int productID;
  final String title;
  final String image;
  final String price;
  final int? optionsID;
  final String? options;
  final int quantity;
  final int subtotal;

  CartItemModel({
    required this.productID,
    required this.title,
    required this.image,
    required this.price,
    this.optionsID,
    this.options,
    required this.quantity,
    int? subtotal,
  }) : subtotal = subtotal ?? int.parse(price) * quantity;

  @override
  String toString() {
    return 'CartItemModel(productID: $productID, title: $title, image: $image, price: $price, optionsID: $optionsID, options: $options, quantity: $quantity, subtotal: $subtotal)';
  }
}
