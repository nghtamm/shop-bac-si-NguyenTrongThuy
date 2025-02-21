import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/repository/auth_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class GetAuthStateUseCase implements UseCase<bool, dynamic> {
  @override
  Future<bool> call({params}) async {
    return serviceLocator<AuthenticationRepository>().getAuthState();
  }
}
