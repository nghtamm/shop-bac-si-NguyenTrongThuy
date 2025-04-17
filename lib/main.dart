import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/app.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/adapters/cart_item_model_adapter.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/adapters/chat_message_adapter.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/adapters/user_model_adapter.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/local/global_storage.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // START: Register adapters
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(CartItemModelAdapter());
  Hive.registerAdapter(ChatMessageAdapter());
  // END: Register adapters
  await Hive.openBox(StorageKey.globalStorage);
  await dotenv.load(
    fileName: '.env',
  );
  await initializeDependencies();
  runApp(const MyApp());
}
