class ProductOrderedEntity {
  final String productID;
  final String productTitle;
  final num productQuantity;
  final num productPrice;
  final num totalPrice;
  final String productImage;
  final String createdDate;
  final String id;

  ProductOrderedEntity({
    required this.productID,
    required this.productTitle,
    required this.productQuantity,
    required this.productPrice,
    required this.totalPrice,
    required this.productImage,
    required this.createdDate,
    required this.id,
  });
}
