import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_theme.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/get_started/views/pages/get_started.dart';
import 'package:shop_bacsi_nguyentrongthuy/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(
    fileName: '.env',
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Bác sĩ Nguyễn Trọng Thủy',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: const GetStartedPage(),
    );
  }
}
