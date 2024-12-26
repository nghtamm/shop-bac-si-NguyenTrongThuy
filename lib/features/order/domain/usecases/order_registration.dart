import 'package:dartz/dartz.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/usecase/use_case.dart';

import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/order_registration_req.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/repository/order.dart';
import 'package:shop_bacsi_nguyentrongthuy/service_locator.dart';

class OrderRegistrationUseCase
    implements UseCase<Either, OrderRegistrationReq> {
  @override
  Future<Either> call({OrderRegistrationReq? params}) async {
    return serviceLocator<OrderRepository>().orderRegistration(params!);
  }
}
