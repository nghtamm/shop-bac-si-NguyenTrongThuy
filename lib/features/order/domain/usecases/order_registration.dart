import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';

import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/order_registration_req.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/repository/order_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class OrderRegistrationUseCase
    implements UseCase<Either, OrderRegistrationReq> {
  @override
  Future<Either> call({OrderRegistrationReq? params}) async {
    return serviceLocator<OrderRepository>().orderRegistration(params!);
  }
}
