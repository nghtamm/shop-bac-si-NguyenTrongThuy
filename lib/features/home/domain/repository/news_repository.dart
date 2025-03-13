import 'package:fpdart/fpdart.dart';

abstract class NewRepository {
  Future<Either> getNews();
}