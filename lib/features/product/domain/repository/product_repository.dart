import 'package:fpdart/fpdart.dart';

abstract class ProductRepository {
  Future<Either> getDoctorChoice();
}