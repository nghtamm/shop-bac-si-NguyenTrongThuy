import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/get_display_name_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/get_started/views/bloc/auth_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/service_locator.dart';

class AuthenticationCubit extends HydratedCubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitialize());

  void appStarted() async {
    var currentAuthState = await serviceLocator<GetAuthStateUseCase>().call();
    if (currentAuthState) {
      var displayName = await serviceLocator<GetDisplayNameUseCase>().call();
      emit(Authenticated(displayName));
    } else {
      emit(NotAuthenticated());
    }
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    if (json['displayName'] != null) {
      return Authenticated.fromJson(json);
    } else {
      return NotAuthenticated();
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    if (state is Authenticated) {
      return state.toJson();
    } else {
      return null;
    }
  }
}
