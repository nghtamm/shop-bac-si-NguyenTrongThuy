import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProductFirebaseService {
  Future<Either> getDoctorChoice();

  Future<Either> getProductByTitle(String title);

  Future<Either> getAllProduct();
}

class ProductFirebaseServiceImpl implements ProductFirebaseService {
  @override
  Future<Either> getDoctorChoice() async {
    try {
      var productData = await FirebaseFirestore.instance
          .collection('Products')
          .where('salesCount', isGreaterThanOrEqualTo: 30)
          .get();
      return Right(productData.docs.map((e) => e.data()).toList());
    } catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either> getProductByTitle(String title) async {
    try {
      final String lowercaseTitle = title.toLowerCase();

      var productData =
          await FirebaseFirestore.instance.collection('Products').get();

      final processedData = productData.docs.map((e) => e.data()).where(
        (product) {
          final processedTitle = (product['title'] as String).toLowerCase();
          return processedTitle.contains(lowercaseTitle);
        },
      ).toList();

      return Right(processedData);
    } catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either> getAllProduct() async {
    try {
      var productData =
          await FirebaseFirestore.instance.collection('Products').get();
      print("Firestore returned ${productData.docs.length} documents");

      return Right(productData.docs.map((e) => e.data()).toList());
    } catch (err) {
      return Left(err);
    }
  }
}
