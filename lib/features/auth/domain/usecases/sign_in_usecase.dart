import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/models/auth_request.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/repository/auth_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class SignInUseCase implements UseCase<Either, AuthenticationRequest> {
  @override
  Future<Either> call({AuthenticationRequest? params}) async {
    if (params == null) {
      return const Left("Không có tham số được truyền vào!");
    }
    return serviceLocator<AuthenticationRepository>().signIn(params);
  }
}
