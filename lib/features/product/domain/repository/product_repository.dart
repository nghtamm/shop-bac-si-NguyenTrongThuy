import 'package:fpdart/fpdart.dart';

abstract class ProductRepository {
  Future<Either> getDoctorChoice();
  
  Future<Either> getProductByTitle(String title);

  Future<Either> getAllProduct();
}