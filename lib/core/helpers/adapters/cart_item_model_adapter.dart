import 'package:hive/hive.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/order/cart_item_model.dart';

class CartItemModelAdapter extends TypeAdapter<CartItemModel> {
  @override
  final int typeId = 2;

  @override
  CartItemModel read(BinaryReader reader) {
    return CartItemModel(
      productID: reader.readInt(),
      title: reader.readString(),
      image: reader.readString(),
      price: reader.readString(),
      options: reader.readString(),
      optionsID: reader.readInt(),
      quantity: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, CartItemModel obj) {
    writer.writeInt(obj.productID);
    writer.writeString(obj.title);
    writer.writeString(obj.image);
    writer.writeString(obj.price);
    writer.writeString(obj.options ?? '');
    writer.writeInt(obj.optionsID ?? 0);
    writer.writeInt(obj.quantity);
  }
}
