import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/models/auth_request.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/get_display_name_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/google_sign_in_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_up_usecase.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    var isAuthenticated = await serviceLocator<GetAuthStateUseCase>().call();
    if (isAuthenticated) {
      var displayName = await serviceLocator<GetDisplayNameUseCase>().call();
      emit(Authenticated(displayName: displayName));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    var result = await serviceLocator<SignUpUseCase>().call(
      params: AuthenticationRequest(
        displayName: event.displayName,
        email: event.email,
        password: event.password,
      ),
    );

    await result.fold(
      (left) async => emit(AuthFailure(message: left)),
      (right) async {
        emit(Unauthenticated());
        final user = FirebaseAuth.instance.currentUser;
        await user?.updateDisplayName(event.displayName);
      },
    );
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    var result = await serviceLocator<SignInUseCase>().call(
      params: AuthenticationRequest(
        email: event.email,
        password: event.password,
      ),
    );

    await result.fold(
      (left) async => emit(AuthFailure(message: left)),
      (success) async {
        var displayName = await serviceLocator<GetDisplayNameUseCase>().call();
        emit(Authenticated(displayName: displayName));
      },
    );
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    await FirebaseAuth.instance.signOut();
    emit(Unauthenticated());
  }

  Future<void> _onGoogleSignInRequested(
      GoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    var result = await serviceLocator<GoogleSignInUseCase>().call();

    await result.fold(
      (left) async => emit(AuthFailure(message: left)),
      (right) async {
        var displayName = await serviceLocator<GetDisplayNameUseCase>().call();
        emit(Authenticated(displayName: displayName));
      },
    );
  }

  Future<void> _onForgotPasswordRequested(
      ForgotPasswordRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    var result = await serviceLocator<ResetPasswordUseCase>().call(
      params: event.email,
    );

    await result.fold(
      (left) async => emit(AuthFailure(message: left)),
      (right) async => emit(PasswordResetSuccess(message: right)),
    );
  }
}
