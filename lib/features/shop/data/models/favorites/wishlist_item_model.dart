class WishlistItemModel {
  final int itemID;
  final int productID;

  WishlistItemModel({
    required this.itemID,
    required this.productID,
  });

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      itemID: json['item_id'] ?? 0,
      productID: json['product_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemID,
      'product_id': productID,
    };
  }
}
