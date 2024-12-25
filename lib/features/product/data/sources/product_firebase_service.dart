import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';

abstract class ProductFirebaseService {
  Future<Either> getDoctorChoice();

  Future<Either> getProductByTitle(String title);

  Future<Either> getAllProduct();

  Future<Either> toggleFavorite(ProductEntity product);

  Future<bool> getFavoriteState(String productID);

  Future<Either> getFavoriteProducts();
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
      return Right(productData.docs.map((e) => e.data()).toList());
    } catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either> toggleFavorite(ProductEntity product) async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      var favoriteProducts = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('Favorites')
          .where('productID', isEqualTo: product.productID)
          .get();
      if (favoriteProducts.docs.isNotEmpty) {
        await favoriteProducts.docs.first.reference.delete();
        return const Right(false);
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .collection('Favorites')
            .add(product.fromEntity().toMap());
        return const Right(true);
      }
    } catch (err) {
      return Left(err);
    }
  }

  @override
  Future<bool> getFavoriteState(String productID) async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      var favoriteProducts = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('Favorites')
          .where('productID', isEqualTo: productID)
          .get();
      if (favoriteProducts.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  @override
  Future<Either> getFavoriteProducts() async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      var favoriteProducts = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('Favorites')
          .get();
      return Right(favoriteProducts.docs.map((e) => e.data()).toList());
    } catch (err) {
      return Left(err);
    }
  }
}
