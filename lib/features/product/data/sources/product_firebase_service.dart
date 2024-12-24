import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProductFirebaseService {
  Future<Either> getDoctorChoice();
}

class ProductFirebaseServiceImpl implements ProductFirebaseService {
  @override
  Future<Either> getDoctorChoice() async {
    try {
      var productData = await FirebaseFirestore.instance.collection('Products').where('salesCount', isGreaterThanOrEqualTo: 30).get();
      return Right(productData.docs.map((e) => e.data()).toList());
    } catch (err) {
      return Left(err);
    }
  }
}
