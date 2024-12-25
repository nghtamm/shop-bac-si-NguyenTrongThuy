import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/usecase/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/repository/auth_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/service_locator.dart';

class ResetPasswordUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    if (params == null) {
      return const Left("Không có tham số được truyền vào!");
    }
    return serviceLocator<AuthenticationRepository>().resetPassword(params);
  }
}