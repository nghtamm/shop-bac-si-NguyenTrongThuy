class AddToCartReq {
  final String productID;
  final String productTitle;
  final num productQuantity;
  final num productPrice;
  final num totalPrice;
  final String productImage;
  final String createdDate;

  AddToCartReq({
    required this.productID,
    required this.productTitle,
    required this.productQuantity,
    required this.productPrice,
    required this.totalPrice,
    required this.productImage,
    required this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productID': productID,
      'productTitle': productTitle,
      'productQuantity': productQuantity,
      'productPrice': productPrice,
      'totalPrice': totalPrice,
      'productImage': productImage,
      'createdDate': createdDate,
    };
  }
}
