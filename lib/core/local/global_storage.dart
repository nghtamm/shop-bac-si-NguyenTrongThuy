import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/models/user_model.dart';

class StorageKey {
  const StorageKey._();

  static const String globalStorage = 'global_storage';
  static const String accessToken = 'access_token';
  static const String userModel = 'user_model';
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

  //Sharekey
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
  String? get shareKey => _box.get(StorageKey.shareKey);

  @override
  Future<void> saveShareKey(String shareKey) async{
    await _box.put(StorageKey.shareKey, shareKey);
  }

  @override
  Future<void> clearShareKey() async {
    await _box.delete(StorageKey.shareKey);
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

}
