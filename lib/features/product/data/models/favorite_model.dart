class FavoriteModel {
  final int productID;
  // final int itemID;
  final String title;
  final String permalink;
  final String description;
  final String shortDescription;
  final List<String> images;
  final String price;
  final String? regularPrice;
  final String? salePrice;

  FavoriteModel({
    required this.productID,
    // required this.itemID,
    required this.title,
    required this.permalink,
    required this.description,
    required this.shortDescription,
    required this.images,
    required this.price,
    this.regularPrice,
    this.salePrice,

  });

factory FavoriteModel.fromJson(Map<String, dynamic> json) {
  return FavoriteModel(
    productID: json['product_id'] ?? 0,
    title: json['name'] ?? '', // Nếu API không trả về `name`, bạn cần bổ sung từ `ProductModel`.
    permalink: json['permalink'] ?? '',
    description: json['description'] ?? '',
    shortDescription: json['short_description'] ?? '',
    images: [], // Hình ảnh sẽ được bổ sung từ `ProductModel`.
    price: json['price']?.toString() ?? '0',
    regularPrice: null,
    salePrice: null,
  );
}

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': productID,
      // 'item_id' : itemID,
      'name': title,
      'permalink': permalink,
      'description': description,
      'short_description': shortDescription,
      'images': images.map((e) => {'src': e}).toList(),
      'price': price,
      'regular_price': regularPrice,
      'sale_price': salePrice,
    };
  }
}
