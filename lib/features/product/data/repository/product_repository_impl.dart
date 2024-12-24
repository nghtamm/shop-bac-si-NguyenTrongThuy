import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/sources/product_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/repository/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/service_locator.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<Either> getDoctorChoice() async {
    var productData =
        await serviceLocator<ProductFirebaseService>().getDoctorChoice();
    return productData.fold((left) {
      return Left(left);
    }, (right) {
      return Right(List.from(right)
          .map((e) => ProductModel.fromMap(e).toEntity())
          .toList());
    });
  }
}
