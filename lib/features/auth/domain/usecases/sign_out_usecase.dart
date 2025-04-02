import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/repository/auth_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class SignOutUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({void params}) async {
    return serviceLocator<AuthenticationRepository>().signOut();
  }
}
