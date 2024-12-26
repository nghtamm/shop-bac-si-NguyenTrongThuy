import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_theme.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/toggle_password_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/get_started/views/bloc/auth_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/get_started/views/bloc/auth_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/get_started/views/pages/get_started.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/pages/home.dart';
import 'package:shop_bacsi_nguyentrongthuy/firebase_options.dart';
import 'package:shop_bacsi_nguyentrongthuy/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await dotenv.load(
    fileName: '.env',
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TogglePasswordCubit(),
        ),
        BlocProvider(
          create: (_) => AuthenticationCubit()..appStarted(),
        ),
      ],
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, authState) {
          if (authState is Authenticated) {
            return MaterialApp(
              title: 'Shop Bác sĩ Nguyễn Trọng Thủy',
              theme: AppTheme.lightTheme,
              themeMode: ThemeMode.light,
              home: HomePage(displayName: authState.displayName),
              // home: AiChat(),
            );
          } else {
            return MaterialApp(
              title: 'Shop Bác sĩ Nguyễn Trọng Thủy',
              theme: AppTheme.lightTheme,
              themeMode: ThemeMode.light,
              home: const GetStartedPage(),
            );
          }
        },
      ),
    );
  }
}
