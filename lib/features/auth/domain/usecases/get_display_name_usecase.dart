import 'package:shop_bacsi_nguyentrongthuy/core/usecase/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/repository/auth_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/service_locator.dart';

class GetDisplayNameUseCase implements UseCase<String, dynamic> {
  @override
  Future<String> call({params}) async {
    return serviceLocator<AuthenticationRepository>().getDisplayName();
  }
}
