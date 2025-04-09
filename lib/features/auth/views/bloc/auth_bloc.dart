import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/local/global_storage.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/authenticate_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/user_validate_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/google_sign_in_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_up_usecase.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<UserValidated>(_onUserValidated);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
  }

  Future<void> _onUserValidated(
    UserValidated event,
    Emitter<AuthState> emit,
  ) async {
    await serviceLocator<UserValidateUseCase>().call(
      params: {
        'rest_route': '/simple-jwt-login/v1/auth/validate',
        'JWT': serviceLocator<GlobalStorage>().accessToken,
      },
    );

    final user = serviceLocator<GlobalStorage>().user;
    if (user != null) {
      emit(
        Authenticated(
          displayName: user.displayName!,
        ),
      );
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    var result = await serviceLocator<SignUpUseCase>().call(
      params: {
        'rest_route': '/simple-jwt-login/v1/users',
        'email': event.email,
        'password': event.password,
        'AUTH_KEY': dotenv.env['JWT_SUBSCRIBER_AUTH_KEY'],
        'first_name': event.firstName,
        'last_name': event.lastName,
        'display_name': event.displayName,
        'user_login': event.userLogin,
        'user_nicename': event.userNicename,
      },
    );

    await result.fold(
      (left) async {
        emit(
          AuthFailure(
            message: left,
          ),
        );
        // event.completer!.complete();
      },
      (right) async {
        emit(Unauthenticated());
        // event.completer!.complete();
      },
    );
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    await serviceLocator<AuthenticateUseCase>().call(
      params: {
        'rest_route': '/simple-jwt-login/v1/auth',
        'email': event.email,
        'password': event.password,
      },
    );

    final result = await serviceLocator<SignInUseCase>().call(params: {
      'rest_route': '/simple-jwt-login/v1/autologin',
      'JWT': serviceLocator<GlobalStorage>().accessToken,
    });

    await result.fold(
      (left) async => emit(
        AuthFailure(
          message: left,
        ),
      ),
      (right) async {
        add(UserValidated());
      },
    );
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await serviceLocator<SignOutUseCase>().call();

    emit(Unauthenticated());
  }

  Future<void> _onForgotPasswordRequested(
    ForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    var result = await serviceLocator<ResetPasswordUseCase>().call(
      params: {
        'rest_route': '/simple-jwt-login/v1/user/reset_password',
        'email': event.email,
      },
    );

    await result.fold(
      (left) async => emit(
        AuthFailure(
          message: left,
        ),
      ),
      (right) async => emit(
        PasswordResetSuccess(
          message: right,
        ),
      ),
    );
  }

  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    var result = await serviceLocator<GoogleSignInUseCase>().call();

    await result.fold(
      (left) async => emit(
        AuthFailure(
          message: left,
        ),
      ),
      (right) async {
        if (right is String) {
          add(UserValidated());
        } else if (right is Map<String, dynamic>) {
          emit(
            Unauthenticated(
              userData: right,
            ),
          );
        }
      },
    );
  }
}
