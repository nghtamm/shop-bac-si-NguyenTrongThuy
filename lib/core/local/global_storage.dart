import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/models/user_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/order/cart_item_model.dart';

class StorageKey {
  const StorageKey._();

  static const String globalStorage = 'global_storage';
  static const String accessToken = 'access_token';
  static const String userModel = 'user_model';
  static const String cartItems = 'cart_items';
  static const String shareKey = 'share_key';
}

abstract class GlobalStorage {
  // Hive Initilization
  Future<void> init();

  // AccessToken
  String? get accessToken;
  Future<void> saveToken(String token);
  Future<void> clearToken();

  // UserModel
  UserModel? get user;
  Future<void> saveUser(UserModel user);
  Future<void> clearUser();

  // Cart
  List<CartItemModel>? get cart;
  Future<void> addToCart(CartItemModel item);
  Future<void> removeFromCart(String productID);
  Future<void> clearCart();

  // TI Wishlist ShareKey
  String? get shareKey;
  Future<void> saveShareKey(String shareKey);
  Future<void> clearShareKey();
}

class GlobalStorageImpl implements GlobalStorage {
  late Box _box;

  @override
  Future<void> init() async {
    _box = await Hive.openBox(StorageKey.globalStorage);
  }

  @override
  String? get accessToken => _box.get(StorageKey.accessToken);

  @override
  Future<void> saveToken(String token) async {
    await _box.put(StorageKey.accessToken, token);
  }

  @override
  Future<void> clearToken() async {
    await _box.delete(StorageKey.accessToken);
  }

  @override
  UserModel? get user => _box.get(StorageKey.userModel);

  @override
  Future<void> saveUser(UserModel user) async {
    await _box.put(StorageKey.userModel, user);
  }

  @override
  Future<void> clearUser() async {
    await _box.delete(StorageKey.userModel);
  }

  @override
  List<CartItemModel>? get cart {
    final List<CartItemModel>? cart;
    cart = (_box.get(StorageKey.cartItems) as List?)?.cast<CartItemModel>();
    return cart ?? <CartItemModel>[];
  }

  @override
  Future<void> addToCart(CartItemModel item) async {
    final cart = this.cart ?? <CartItemModel>[];

    final existingItemIndex = cart.indexWhere(
      (cartItem) =>
          cartItem.productID == item.productID &&
          cartItem.optionsID == item.optionsID,
    );
    if (existingItemIndex != -1) {
      cart[existingItemIndex] = CartItemModel(
        productID: cart[existingItemIndex].productID,
        title: cart[existingItemIndex].title,
        image: cart[existingItemIndex].image,
        price: cart[existingItemIndex].price,
        options: cart[existingItemIndex].options,
        optionsID: cart[existingItemIndex].optionsID,
        quantity: cart[existingItemIndex].quantity + item.quantity,
      );
    } else {
      cart.add(item);
    }

    await _box.put(StorageKey.cartItems, cart);
  }

  @override
  Future<void> removeFromCart(String key) async {
    final cart = this.cart ?? <CartItemModel>[];

    final parts = key.split('-');
    final productID = int.tryParse(parts[0]);
    final optionsID = int.tryParse(parts[1]);

    cart.removeWhere(
      (item) => item.productID == productID && item.optionsID == optionsID,
    );

    await _box.put(StorageKey.cartItems, cart);
  }

  @override
  Future<void> clearCart() async {
    await _box.delete(StorageKey.cartItems);
  }

  @override
  String? get shareKey => _box.get(StorageKey.shareKey);

  @override
  Future<void> saveShareKey(String shareKey) async {
    await _box.put(StorageKey.shareKey, shareKey);
  }

  @override
  Future<void> clearShareKey() async {
    await _box.delete(StorageKey.shareKey);
  }
}
