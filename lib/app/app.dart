import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/app_routers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_theme.dart';
<<<<<<< HEAD
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/toggle_password_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/get_started/views/bloc/auth_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/get_started/views/bloc/auth_state.dart';
=======
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/auth_bloc.dart';
>>>>>>> nghtamm2003/refactor

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TogglePasswordCubit(),
        ),
        BlocProvider(
          create: (_) => AuthenticationCubit()..appStarted(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
=======
    return BlocProvider(
      create: (_) => AuthBloc()..add(AppStarted()),
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        child: BlocBuilder<AuthBloc, AuthState>(
>>>>>>> nghtamm2003/refactor
          builder: (context, authState) {
            return MaterialApp.router(
              title: 'Shop Bác sĩ Nguyễn Trọng Thủy',
              theme: AppTheme.lightTheme,
              themeMode: ThemeMode.light,
              routerConfig: AppRouters.router,
            );
          },
        ),
      ),
    );
  }
}
