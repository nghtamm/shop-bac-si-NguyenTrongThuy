import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/app.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/adapters/user_model_adapter.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/local/global_storage.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/repository/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/bloc/favorite_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/firebase_options.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox(StorageKey.globalStorage);
  await dotenv.load(
    fileName: '.env',
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        RepositoryProvider<ProductRepository>(
          create: (_) => serviceLocator<ProductRepository>(),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(
            productRepository: context.read<ProductRepository>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
